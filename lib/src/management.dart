import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mive/provider/memberProvider.dart';
import 'package:mive/src/menutest.dart';

class Management extends StatefulWidget {
  Management({Key? key, this.mem}) : super(key: key);
  Member? mem;

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> with TickerProviderStateMixin {

  late final AnimationController _lottieController;

  @override
  void initState(){
    super.initState();

    _lottieController = AnimationController(vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    // if(widget.mem == null){
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Error')));
    //   Navigator.pop(context);
    // }
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: TextButton(
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
            child: const Text(
              'MIVE',
              style: TextStyle(color: Colors.white),

            )),
      ),
      backgroundColor: const Color(0xff4AC1F2),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                child: Lottie.asset('assets/exercise.json',),
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(20.0),
                //     child: Image.asset(
                //       'assets/exercise.png',
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                onTap: () {Navigator.popUntil(context, ModalRoute.withName('/training'));},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                child: Lottie.asset('assets/diet.json'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
