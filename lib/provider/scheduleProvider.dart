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

  Map<String, String> changeDay = {
    'Mon' : 'MO',
    'Tue' : 'TU',
    'Wed' : 'WE',
    'Thu' : 'TH',
    'Fri' : 'FR',
    'Sat' : 'SA',
    'Sun' : 'SU'
  };

  final scheduleDB = FirebaseFirestore.instance
      .collection('members'); //.doc('yooisae').collection('schedules');
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
            .collection('members')
            .snapshots()
            .listen((event) {
          mySchedules = [];
          for (final member in event.docs) {
            if(member.data().isEmpty){
              continue;
            }
            DateTime _start = member.data()['start'].toDate();
            DateTime _end = _start.add(const Duration(hours: 1));
            List<String> byday = member.data()['day'].cast<String>();
            List<String> byDay = [];
            for(final temp in byday){
              byDay.add(changeDay[temp]!);
            }
            String ByDay = byDay.join(',');
            int count = int.parse(member.data()['duration'].toString().replaceAll('week', '')) * byday.length;
            String _rule = 'FREQ=WEEKLY;INTERVAL=1;BYDAY='+ByDay+';COUNT='+count.toString();
            print(_rule);
            mySchedules.add(
              Meeting(
                eventName: member.data()['name'].toString(),
                from: _start,
                to: _end,
                isAllDay: false,
                docId: member.id,
                background: const Color(0xff4AC1F2),
                isman: member.data()['isMan'],
                recurrenceRule: _rule,

                  //FREQ=DAILY;INTERVAL=7;COUNT=10'
              ),
            );
            notifyListeners();
          }
        });
        notifyListeners();
      }
    });
  }

  // void addSchedule(
  //     String name,
  //     DateTime from,
  //     DateTime to,
  //     String type,
  //     ) async {
  //   Map<String, dynamic> scheduleInfo = <String, dynamic>{
  //     "schedule name": name,
  //     "schedule start": Timestamp.fromDate(from),
  //     "schedule end": Timestamp.fromDate(to),
  //     "type" : type,
  //   };
    // mySchedules.add(
    //   Meeting(
    //       eventName: name,
    //       from: from,
    //       to: to,
    //       isAllDay: false,
    //       docId: '-',
    //       background: type == 'Personal'?const Color(0xFFB90000) : const Color(0xff4AC1F2),
    //       type: type),
    // );
  //
  //   await scheduleDB
  //       .doc(FirebaseAuth.instance.currentUser!.uid.toString())
  //       .collection('schedules')
  //       .add(scheduleInfo);
  //   notifyListeners();
  // }

  // void editSchedule(Meeting schedule) {
  //   scheduleDB
  //       .doc(curUserID)
  //       .collection('schedules')
  //       .doc(schedule.docId)
  //       .update(<String, dynamic>{
  //     "schedule name": schedule.eventName,
  //     "schedule start": schedule.from,
  //     "schedule end": schedule.to,
  //     "type" : schedule.type,
  //   });
  //   notifyListeners();
  // }

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
    required this.isman,
    this.recurrenceRule
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

  bool isman;

  String docId;

  String? recurrenceRule;
}
