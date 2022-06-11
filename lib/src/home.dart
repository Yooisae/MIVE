import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mive/src/signin.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../provider/scheduleProvider.dart';
import '../widgets/miveWidgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> user) {
        if (!user.hasData) {
          return const Signin();
        } else {
          print('user ID: ${user.data?.uid.toString()}');
          return const HomePage();
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool status = true;
  final _formKey = GlobalKey<FormState>();

  final CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIVE'),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/addmember'), icon: const Icon(Icons.person_add_alt_1_rounded))
        ],
      ),
      drawer: MiveWidgets().MiveDrawer(context),
      body: Consumer<ScheduleProvider>(
        builder: (context, state, _) => SfCalendar(
          controller: _controller,
          view: CalendarView.week,
          initialSelectedDate: DateTime.now(),
          initialDisplayDate: DateTime.now(),
          dataSource: MeetingDataSource(state.getSchedules),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true),
          todayHighlightColor: const Color(0xff4AC1F2),
          timeZone: 'Korea Standard Time',
          allowDragAndDrop: true,
          showCurrentTimeIndicator: true,
          allowViewNavigation: true,
          allowedViews: const [CalendarView.week, CalendarView.month],
        ),
      ),
    );
  }
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  @override
  String getRecurrenceRule(int index) {
    return appointments![index].recurrenceRule;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
