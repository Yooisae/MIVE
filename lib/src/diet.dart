import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Diet extends StatelessWidget {
  const Diet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.asset('assets/comingsoon.json'),
            const Text('Coming Soon', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),),
          ],
        ),
      ),
    );
  }
}
