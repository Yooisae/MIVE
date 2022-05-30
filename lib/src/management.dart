import 'package:flutter/material.dart';
import 'package:mive/src/menutest.dart';

class Management extends StatelessWidget {
  const Management({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: TextButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: const Text(
              'MIVE',
              style: TextStyle(color: Colors.white),
            )),
      ),
      backgroundColor: const Color(0xff4AC1F2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/exercise.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));},
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/diet.png',
                        fit: BoxFit.fill,
                      ),
                    )),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
