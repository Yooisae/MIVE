import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ScheduleProvider() {
    init();
  }

  List<Meeting> mySchedules = [];

  final scheduleDB = FirebaseFirestore.instance
      .collection('schedules'); //.doc('yooisae').collection('schedules');
  DocumentSnapshot? curUserDB;
  String? curUserID;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        curUserID = user.uid;
        print(curUserID);
        curUserDB = await scheduleDB.doc(curUserID).get();
        if (!curUserDB!.exists) {
          //await scheduleDB.doc(user.uid).set({"private": true});
        } else {
          //Map<String, dynamic> data = curUserDB!.data() as Map<String, dynamic>;
        }
        scheduleDB
            .doc(curUserID)
            .collection('schedules')
            .snapshots()
            .listen((event) {
          mySchedules = [];
          for (final schedule in event.docs) {
            if(schedule.data().isEmpty){
              continue;
            }
            mySchedules.add(
              Meeting(
                eventName: schedule.data()['schedule name'].toString(),
                from: schedule.data()['schedule start'].toDate(),
                to: schedule.data()['schedule end'].toDate(),
                isAllDay: false,
                docId: schedule.id,
                background: schedule.data()['type'] == "Personal"?const Color(0xFFB90000) : const Color(0xff4AC1F2),
                type: schedule.data()['type'],
                //recurrenceRule: 'FREQ=DAILY;INTERVAL=7;COUNT=10'
              ),
            );
            notifyListeners();
          }
        });
        notifyListeners();
      }
    });
  }

  void addSchedule(
      String name,
      DateTime from,
      DateTime to,
      String type,
      ) async {
    Map<String, dynamic> scheduleInfo = <String, dynamic>{
      "schedule name": name,
      "schedule start": Timestamp.fromDate(from),
      "schedule end": Timestamp.fromDate(to),
      "type" : type,
    };
    mySchedules.add(
      Meeting(
          eventName: name,
          from: from,
          to: to,
          isAllDay: false,
          docId: '-',
          background: type == 'Personal'?const Color(0xFFB90000) : const Color(0xff4AC1F2),
          type: type),
    );

    await scheduleDB
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('schedules')
        .add(scheduleInfo);
    notifyListeners();
  }

  void editSchedule(Meeting schedule) {
    scheduleDB
        .doc(curUserID)
        .collection('schedules')
        .doc(schedule.docId)
        .update(<String, dynamic>{
      "schedule name": schedule.eventName,
      "schedule start": schedule.from,
      "schedule end": schedule.to,
      "type" : schedule.type,
    });
    notifyListeners();
  }

  void deleteSchedule(Meeting schedule) async {
    await scheduleDB
        .doc(curUserID)
        .collection('schedules')
        .doc(schedule.docId)
        .delete();
    notifyListeners();
  }

  List<Meeting> get getSchedules => mySchedules;
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
    required this.docId,
    required this.type,
    //this.recurrenceRule
  });

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

  String type;

  String docId;

//String? recurrenceRule;
}
