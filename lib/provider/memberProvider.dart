import 'dart:convert';

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
  List ListMembers = [];

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
          ListMembers = [];
          for (final member in event.docs) {
            if (member.data().isEmpty) {
              continue;
            }
            List<dynamic> tmp = member.data()['day'];
            final List<String> day = tmp.cast<String>();
            members.add(
              Member(
                name: member.data()['name'].toString(),
                start: member.data()['start'].toDate(),
                duration: member.data()['duration'].toString(),
                docId: member.id,
                age: member.data()['age'],
                isMan: member.data()['isMan'],
                day: day,
              ),
            );
            ListMembers.add({
              'name': member.data()['name'].toString(),
              'group': '개인PT',
              'id': member.id
            });
            notifyListeners();
          }
        });
        notifyListeners();
      }
    });
  }

  Future<String> addMember(Member member) async {
    print('add cur user id: ${curUserID}');
    Map<String, dynamic> scheduleInfo = <String, dynamic>{
      "name": member.name,
      "start": Timestamp.fromDate(member.start),
      "duration": member.duration,
      "age": member.age,
      "isMan": member.isMan,
      "day": member.day,
    };
    members.add(member);

    DocumentReference<Map<String, dynamic>> newmember = await membersDB
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('members')
        .add(scheduleInfo);
    notifyListeners();
    print('Provider: ${newmember.id}');
    return newmember.id;
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

  Member getmeber(String id) {
    for (int i = 0; i < members.length; i++) {
      if (members[i].docId == id) {
        return members[i];
      }
    }
    return members[0];
  }

  List<String> sequence = ['foot', 'knee', 'back'];
  List<String> memSeq = [];
  List<String> get memseq => memSeq;

  Future<List<String>> memberSequence(String id) async{
    memSeq.clear();
    await FirebaseFirestore.instance
        .collection('members')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('members')
        .doc(id)
        .get()
        .then((value) async{
      for (int i = 0; i < 3; i++) {
        await FirebaseFirestore.instance
            .collection('exercise')
            .doc(sequence[i])
            .collection(sequence[i])
            .doc(value['exercise'][i])
            .get()
            .then((value) {
          if (value.data() != null || value.exists) {
            memSeq.add(value.data()!['c'][0]);
            memSeq.add(value.data()!['i'][0]);
            memSeq.add(value.data()!['b'][0]);
            memSeq.add(value.data()!['g'][0]);
            print(value.data()!['c'][0]);
            print(value.data()!['i'][0]);
            print(value.data()!['b'][0]);
            print(value.data()!['g'][0]);
          }
          notifyListeners();
        });
      }

    });
    print('제발좀${memSeq.length}');
    print(memSeq.first);
    return memSeq;
    notifyListeners();
  }

  List<Member> get getMembers => members;

  List getListMembers() {
    return ListMembers;
  }
}

class Member {
  /// Creates a meeting class with required details.
  Member(
      {required this.name,
      required this.start,
      required this.duration,
      required this.docId,
      required this.age,
      required this.isMan,
      required this.day});

  String name;

  DateTime start;

  String duration;

  String docId;

  int age;

  bool isMan;

  List<String> day;

  String group = 'Personal';
}
