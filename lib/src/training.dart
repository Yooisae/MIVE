import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class Training extends StatefulWidget {
  const Training({Key? key}) : super(key: key);

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {

  //bool

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIVE'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Form(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('하체', style: TextStyle(fontSize: 20,),),
              RoundCheckBox(
                onTap: (value){},
              ),
              const Divider(),

            ],
          )),
        ),
      ),
    );
  }
}
