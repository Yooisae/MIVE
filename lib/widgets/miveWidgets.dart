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
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: ListTile(
              leading: Icon(
                Icons.run_circle,
                color: Colors.black,
              ),
              title: Text('MIVE', style: TextStyle(fontSize: 20),),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Color(0xff4AC1F2),
            ),
            title: const Text('설정'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.map,
              color: Color(0xff4AC1F2),
            ),
            title: const Text('지도'),
            onTap: () {Navigator.pushNamed(context, '/googlemap');},
          ),
          ListTile(
            leading: const Icon(Icons.directions_run, color: Color(0xff4AC1F2),),
            title: const Text('운동관리', ),
            onTap: () {Navigator.pushNamed(context, '/exercise');},
          ),
          ListTile(
            leading: const Icon(Icons.manage_accounts, color: Color(0xff4AC1F2),),
            title: const Text('회원관리', ),
            onTap: () {Navigator.pushNamed(context, '/membermanage');},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Color(0xff4AC1F2),),
            title: const Text('로그아웃'),
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