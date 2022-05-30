import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MemberProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MemberProvider() {
    init();
  }

  List<Member> members = [];

  final membersDB = FirebaseFirestore.instance
      .collection('members'); //.doc('yooisae').collection('schedules');
  DocumentSnapshot? curUserDB;
  String? curUserID;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        curUserID = user.uid;
        print(curUserID);
        curUserDB = await membersDB.doc(curUserID).get();
        if (!curUserDB!.exists) {
          //await scheduleDB.doc(user.uid).set({"private": true});
        } else {
          //Map<String, dynamic> data = curUserDB!.data() as Map<String, dynamic>;
        }
        membersDB
            .doc(curUserID)
            .collection('members')
            .snapshots()
            .listen((event) {
          members = [];
          for (final member in event.docs) {
            if(member.data().isEmpty){
              continue;
            }
            members.add(
              Member(
                name: member.data()['name'].toString(),
                start: member.data()['start'].toDate(),
                end: member.data()['end'].toDate(),
                docId: member.id,
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

  void addMember(
      String name,
      DateTime start,
      DateTime end,
      ) async {
    Map<String, dynamic> scheduleInfo = <String, dynamic>{
      "name": name,
      "start": Timestamp.fromDate(start),
      "end": Timestamp.fromDate(end),
    };
    members.add(
      Member(
          name: name,
          start: start,
          end: start,
          docId: '-',
         ),
    );

    await membersDB
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('members')
        .add(scheduleInfo);
    notifyListeners();
  }

  void editMember(Member schedule) {
    membersDB
        .doc(curUserID)
        .collection('members')
        .doc(schedule.docId)
        .update(<String, dynamic>{
      "name": schedule.name,
      "start": schedule.start,
      "end": schedule.end,
    });
    notifyListeners();
  }

  void deleteMember(Member schedule) async {
    await membersDB
        .doc(curUserID)
        .collection('members')
        .doc(schedule.docId)
        .delete();
    notifyListeners();
  }

  List<Member> get getMembers => members;
}

class Member {
  /// Creates a meeting class with required details.
  Member({
    required this.name,
    required this.start,
    required this.end,
    required this.docId,
    //this.recurrenceRule
  });

  String name;

  DateTime start;

  DateTime end;

  String docId;

//String? recurrenceRule;
}
