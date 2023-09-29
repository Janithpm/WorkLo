import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // spalsh screeen with image and welcome text
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash.png'),
            const SizedBox(height: 30),
            const Text(
              'WorkLo',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 70,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              'Effortlessly organize your life,',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const Text(
              'one task at a time.',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
