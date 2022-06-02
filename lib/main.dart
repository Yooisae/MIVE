import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mive/provider/authProvider.dart';
import 'package:mive/provider/memberProvider.dart';
import 'package:mive/provider/scheduleProvider.dart';
import 'package:mive/src/addMember.dart';
import 'package:mive/src/home.dart';
import 'package:mive/src/management.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'src/googleMapTest.dart';
import 'src/signin.dart';
import 'src/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => AuthProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => ScheduleProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => MemberProvider())
        ],
        child: MaterialApp(
            title: 'MIVE',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  centerTitle: true,
                  titleTextStyle: TextStyle(),
                  backgroundColor: Color(0xff4AC1F2)),
              primarySwatch: Colors.blue,
              textTheme:
                  const TextTheme(bodyText2: TextStyle(color: Colors.black)),
            ),
            home: const Home(),
            initialRoute: '/login',
            routes: {
              //'/' : (context) => const Home(),
              '/login': (context) => const Login(),
              '/signin': (context) => const Signin(),
              '/addmember': (context) => const AddMember(),
              '/management': (context) => Management(),
              '/googlemap' : (context) => const MapSample(),
            }));
  }
}
