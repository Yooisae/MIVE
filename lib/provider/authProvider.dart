import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier, DiagnosticableTreeMixin {
  AuthProvider() {
    init();
  }

  final usersRef = FirebaseFirestore.instance.collection('users');
  DocumentSnapshot? curUser;
  String? curUid;

  Future<void> init() async {
    FirebaseAuth.instance
        .userChanges()
        .listen((user) async {
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
}


