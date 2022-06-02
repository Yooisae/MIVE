import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class MiveWidgets{
  Drawer MiveDrawer(BuildContext context){
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.black,
              ),
              title: const Text('Member List'),
              onTap: () {
                Navigator.pushNamed(context, '/management');
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color(0xff4AC1F2),
            ),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.map,
              color: Color(0xff4AC1F2),
            ),
            title: const Text('Google map'),
            onTap: () {Navigator.pushNamed(context, '/googlemap');},
          ),
          ListTile(
            title: const Text('Sign out'),
            onTap: () {FirebaseAuth.instance.signOut();},
          ),
        ],
      ),
    );
  }

  Row MiveCheckBox(BuildContext context, String title, bool checked){
    return Row(

    );
  }

}