import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _controller1 = TextEditingController();
  final formkey = GlobalKey<FormState>();

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
              // context
              //     .read<MemberProvider>()
              //     .addMember(_controller1.text, startTime, endTime);
              // Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Add Member'),
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
      body: Form(
        key: formkey,
        child: Container(
          //width: MediaQuery.of(context).size.width - 10,
          //height: MediaQuery.of(context).size.height - 80,
          //padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controller1,
                  decoration: const InputDecoration(
                      labelText: 'member name',
                      hintText: 'Enter name',
                      contentPadding: EdgeInsets.only(left: 20)),
                ),
                DateTimePicker(
                  //textAlign: TextAlign.center,
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    //controller: _controller1,
                    initialValue: startTime.toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'Start Date',
                    timeLabelText: "Start Time",
                    //use24HourFormat: false,
                    //locale: Locale('pt', 'BR'),
                    // selectableDayPredicate: (date) {
                    //   if (date.weekday == 6 || date.weekday == 7) {
                    //     return false;
                    //   }
                    //   return true;
                    // },
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
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    //controller: _controller2,
                    initialValue: endTime.toString(),
                    //_controller2.text,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    dateLabelText: 'End Date',
                    timeLabelText: "End Time",
                    //use24HourFormat: false,
                    //locale: Locale('pt', 'BR'),
                    // selectableDayPredicate: (date) {
                    //   if (date.weekday == 6 || date.weekday == 7) {
                    //     return false;
                    //   }
                    //   return true;
                    // },
                    onChanged: (val) => setState(() {
                      //_valueChanged2 = val;
                      endTime = DateTime.parse(val);

                      // if(endTime.isBefore(startTime)){
                      //   print('hi');
                      //   _controller2.clear();
                      //   //_controller2.text = _controller1.text;
                      // }
                      // else{
                      //   _controller2 = TextEditingController(text: val);
                      //   endTime = DateTime.parse(val);
                      // }
                    }),
                    validator: (val) {
                      //setState(() => _valueToValidate2 = val ?? '');
                      print(val);
                      return null;
                    },
                    onSaved: (val) {} //=> setState(() => _valueSaved2 = val ?? ''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
