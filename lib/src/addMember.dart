import 'package:date_time_picker/date_time_picker.dart';
import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import '../provider/memberProvider.dart';

class AddMember extends StatefulWidget {
  const AddMember({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  DateTime startTime = DateTime.parse(DateTime.now().toString());
  DateTime endTime =
      DateTime.parse(DateTime.now().add(const Duration(hours: 2)).toString());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  //final TextEditingController durationController = TextEditingController();
  //final TextEditingController nameController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final isSelected = <bool>[false, true];
  final List<String> items = [
    '8week',
    '12week',
    '15week',
    '18week',
  ];
  List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek(
      "Mon",
    ),
    DayInWeek(
        "Tue",
        isSelected: true
    ),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thu",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
  ];
  List<String> days = [];
  String? duration = '8week';
  final formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff4AC1F2),
        appBar: AppBar(
          backgroundColor: const Color(0xff4AC1F2),
          title: const Text("MIVE"),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 0),
          child: Container(
            //height: MediaQuery.of(context).size.height - 30,
            padding: const EdgeInsets.all(30.0),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            alignment: Alignment.center,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '회원추가',
                    style: TextStyle(
                      color: Color(0xff4AC1F2),
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      //hintText: 'Admin',
                      labelText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter age';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 0.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: ToggleButtons(
                        isSelected: isSelected,
                        color: Colors.black.withOpacity(0.60),
                        selectedColor: Colors.blue,
                        selectedBorderColor: Colors.blue,
                        fillColor: Colors.blue.withOpacity(0.08),
                        splashColor: Colors.blue.withOpacity(0.12),
                        hoverColor: Colors.blue.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(4.0),
                        constraints: const BoxConstraints(minHeight: 36.0),
                        onPressed: (index) {
                          // Respond to button selection
                          setState(() {
                            for (int i = 0; i < isSelected.length; i++) {
                              isSelected[i] = false;
                            }
                            isSelected[index] = !isSelected[index];
                          });
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.man,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.woman),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DateTimePicker(
                      //textAlign: TextAlign.center,
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                      //controller: _controller1,//.text(startTime.toString()),
                      initialValue: startTime.toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: const Icon(Icons.event),
                      dateLabelText: 'Start Date',
                      timeLabelText: "Start Time",
                      onChanged: (val) => setState(() {
                            startTime = DateTime.parse(val);
                            val = startTime.add(Duration(hours: 24)).toString();
                          }),
                      validator: (val) {
                        print(val);
                        print(val.runtimeType);
                        return null;
                      },
                      onSaved:
                          (val) {} //setState(() => _valueSaved1 = val ?? ''),
                      ),
                  DateTimePicker(
                    //textAlign: TextAlign.center,
                      type: DateTimePickerType.time,
                      dateMask: 'HH',
                      //controller: _controller1,//.text(startTime.toString()),
                      initialValue: const Duration(hours: 20, minutes: 0).toString(),
                      initialTime: const TimeOfDay(hour: 20, minute: 0),
                      timePickerEntryModeInput: false,
                      timeLabelText: "Start Time",
                      onChanged: (val) => setState(() {
                        print('이상하네: $val');
                      }),
                      validator: (val) {
                      },
                      onSaved:
                          (val) {} //setState(() => _valueSaved1 = val ?? ''),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const Text('PT days', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectWeekDays(
                        fontSize:10,
                        fontWeight: FontWeight.w500,
                        days: _days,
                        border: false,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [Color(0xff4AC1F2), Color(0xff1D9BCF)],
                            tileMode:
                            TileMode.repeated, // repeats the gradient over the canvas
                          ),
                        ),
                        onSelect: (values) { // <== Callback to handle the selected days
                          days.clear();
                          days.addAll(values);
                          print(values);
                          print("days: $days");
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const Text(
                    "Duration",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select duration',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: duration,
                      onChanged: (value) {
                        setState(() {
                          duration = value as String;
                        });
                      },
                      buttonHeight: 50,
                      buttonWidth: 140,
                      itemHeight: 40,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff1D9BCF))),
                      onPressed: () async{
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          Member member = Member(name: nameController.text, start: startTime, duration: duration.toString(), docId: "-", age: int.parse(ageController.text), isMan: isSelected[0]);
                          context.read<MemberProvider>().addMember(member);
                          nameController.clear();
                          ageController.clear();
                          Navigator.pushNamed(context, '/management', arguments: {"mem":member});
                          //Navigator.popUntil(context, ModalRoute.withName('/'));
                        }
                      },
                      child: const Text('PT 시작하기'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
