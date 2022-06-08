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
                duration: member.data()['duration'].toString(),
                docId: member.id,
                age: member.data()['age'],
                isMan: member.data()['isMan'],
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

  void addMember(Member member) async {
    print(
      'add cur user id: ${curUserID}'
    );
    Map<String, dynamic> scheduleInfo = <String, dynamic>{
      "name": member.name,
      "start": Timestamp.fromDate(member.start),
      "duration": member.duration,
      "age" : member.age,
      "isMan" : member.isMan
    };
    members.add(member);

    await membersDB
        .doc(curUserID)
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
      "duration": schedule.duration,
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
    required this.duration,
    required this.docId,
    required this.age,
    required this.isMan,
    //this.recurrenceRule
  });

  String name;

  DateTime start;

  String duration;

  String docId;

  int age;

  bool isMan;

//String? recurrenceRule;
}
