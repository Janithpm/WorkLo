import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worklo/constants/colors.dart';
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset("assets/b3.svg", height: 450, width: 450),
              const Text(
                'WORKLO',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 80,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'Your Tasks, Your Rules, Welcome Aboard!',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const SizedBox(height: 40),

              //sign in
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1, color: primaryColor),
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
                  child: const Text("Sign In", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 20),
              //sign up
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 1, color: primaryColor),
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
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
