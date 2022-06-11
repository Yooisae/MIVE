import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:survey_kit/survey_kit.dart';

class AuthProvider with ChangeNotifier, DiagnosticableTreeMixin {
  AuthProvider() {
    init();
  }

  final usersRef = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot? curUser;
  String? curUid;

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        curUser = await usersRef.doc(user.uid).get();
        curUid = user.uid;
        print(curUid);
        if (!curUser!.exists) {
          notifyListeners();
        }
        await usersRef.doc(user.uid).get().then((userinfo) {
          // _name = userinfo.data()?['name'];
          // _email = userinfo.data()?['email'];
          // _message = userinfo.data()?['message'];
          notifyListeners();
        });
      } else {
        print('sign out');
      }
      notifyListeners();
    });
  }

  List<String> sequence = ['foot', 'knee', 'back'];

  void getTraining(SurveyResult result, String memberid) async {
    List<String?> exercises = [
      result.results[1].results[0].valueIdentifier,
      result.results[2].results[0].valueIdentifier,
      result.results[3].results[0].valueIdentifier
    ];
    FirebaseFirestore.instance
        .collection('members')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('members')
        .doc(memberid)
        .update({'exercise': exercises});
    }

    // for (int i = 1; i < 4; i++) {
    //   FirebaseFirestore.instance
    //       .collection('exercise')
    //       .doc(sequence[i - 1])
    //       .collection(sequence[i - 1])
    //       .doc(result.results[i].results[0].valueIdentifier)
    //       .get()
    //       .then((value) {
    //     if (value.data() != null) {
    //       print(value.data()!['c'][0]);
    //       print(value.data()!['i'][0]);
    //       print(value.data()!['b'][0]);
    //       print(value.data()!['g'][0]);
    //     }
    //   }
    //   );
    // }
  // }
}
