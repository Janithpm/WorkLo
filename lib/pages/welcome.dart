import 'package:flutter/material.dart';
import 'package:worklo/pages/signin.dart';
import 'package:worklo/pages/signup.dart';

class WelocmePage extends StatelessWidget {
  const WelocmePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // spalsh screeen with image and welcome text
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/splash.png'),
              const SizedBox(height: 20),
              // const Text(
              //   'Welcome to',
              //   style: TextStyle(
              //     color: Colors.black87,
              //     fontSize: 25,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),

              const SizedBox(height: 20),
              const Text(
                'Your Tasks, Your Rules',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Text(
                'Welcome Aboard!',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                'WorkLo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 80,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1, color: const Color(0xFF3b5998)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const SigninPage()),
                            (route) => false);
                      },
                      child:
                          const Text("Sign In", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        // use theme color for btn border and text color

                        side: const BorderSide(
                            width: 1, color: const Color(0xF4110DE3)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const SignupPage()),
                            (route) => false);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
