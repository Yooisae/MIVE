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
        if (user.hasData) {
          return const HomePage();
        } else {
          return const Signin();
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
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         title: const Text('logout'),
      //         onTap: (){FirebaseAuth.instance.signOut();},
      //       )
      //     ],
      //   ),
      // ),
      body: Consumer<ScheduleProvider>(
        builder: (context, state, _) => SfCalendar(
          controller: _controller,
          view: CalendarView.week,
          initialSelectedDate: DateTime.now(),
          initialDisplayDate: DateTime.now(),
          //showDatePickerButton: true,
          dataSource: MeetingDataSource(state.getSchedules),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true),
          todayHighlightColor: const Color(0xff4AC1F2),
          timeZone: 'Korea Standard Time',
          allowDragAndDrop: true,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showGeneralDialog(
      //       barrierLabel: "Label",
      //       barrierDismissible: true,
      //       barrierColor: Colors.black.withOpacity(0.5),
      //       transitionDuration: const Duration(milliseconds: 300),
      //       context: context,
      //       pageBuilder: (context, anim1, anim2) {
      //         return const AddSchedule();
      //       },
      //       transitionBuilder: (context, anim1, anim2, child) {
      //         return SlideTransition(
      //           position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
      //               .animate(anim1),
      //           child: child,
      //         );
      //       },
      //     );
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     size: 50,
      //   ),
      //   backgroundColor: const Color(0xff4AC1F2),
      // ),
    );
  }
}

class AddSchedule extends StatefulWidget {
  const AddSchedule({
    Key? key,
  }) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final List<String> _type = ['Personal', 'Group'];
  String _curType = 'Personal';
  DateTime startTime = DateTime.parse(DateTime.now().toString());
  DateTime endTime =
  DateTime.parse(DateTime.now().add(const Duration(hours: 2)).toString());
  final TextEditingController _controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            )),
        actions: [
          TextButton(
            onPressed: () {
              context
                  .read<ScheduleProvider>()
                  .addSchedule(_controller1.text, startTime, endTime, _curType);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Add schedule'),
              ));
            },
            child: const Text(
              'add',
              style: TextStyle(
                color: Color(0xFFB9C98C),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        //width: MediaQuery.of(context).size.width - 10,
        //height: MediaQuery.of(context).size.height - 80,
        //padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              items: _type.map((value) {
                return DropdownMenuItem(
                    value: value,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          value,
                        )));
              }).toList(),
              value: _curType,
              onChanged: (value) {
                setState(() {
                  _curType = value.toString();
                });
              },
              isExpanded: true,
            ),
            TextFormField(
              controller: _controller1,
              decoration: const InputDecoration(
                  labelText: 'title',
                  hintText: 'Enter title',
                  contentPadding: EdgeInsets.only(left: 20)),
            ),
            DateTimePicker(
              //textAlign: TextAlign.center,
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                //controller: _controller1,
                initialValue: startTime.toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: const Icon(Icons.event),
                dateLabelText: 'Start Date',
                timeLabelText: "Start Time",
                onChanged: (val) => setState(() {
                  startTime = DateTime.parse(val);
                  print(startTime);
                }),
                validator: (val) {
                  //setState(() => _valueToValidate1 = val ?? '');
                  return null;
                },
                onSaved: (val) {} //setState(() => _valueSaved1 = val ?? ''),
            ),
            DateTimePicker(
                enableInteractiveSelection: true,
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                //controller: _controller2,
                initialValue: endTime.toString(),
                //_controller2.text,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: const Icon(Icons.event),
                dateLabelText: 'End Date',
                timeLabelText: "End Time",
                onChanged: (val) => setState(() {
                  //_valueChanged2 = val;
                  endTime = DateTime.parse(val);
                }),
                validator: (val) {
                  return null;
                },
                onSaved: (val) {} //=> setState(() => _valueSaved2 = val ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
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

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
