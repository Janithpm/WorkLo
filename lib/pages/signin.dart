import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worklo/constants/colors.dart';
import 'package:worklo/pages/home.dart';
import 'package:worklo/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../service/auth.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  Auth googleAuth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              "Time to Get Things Done with WorkLo! Sign in to Your Account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w300),
            ),
          ),
          // const Text(
          //   "WORKLO",
          //   style: TextStyle(
          //       color: primaryColor, fontSize: 50, fontWeight: FontWeight.w400),
          // ),
          const SizedBox(
            height: 40,
          ),
          SocialBtn("Continue With Google"),
          const SizedBox(
            height: 50,
          ),
          const Text("Or sign in using Email and Password",
              style: TextStyle(color: Colors.black54, fontSize: 16)),
          const SizedBox(
            height: 30,
          ),
          TextInput("Email Address", emailController),
          const SizedBox(
            height: 15,
          ),
          TextInput("Password", passwordController),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              try {
                firebase_auth.UserCredential user =
                    await auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                print(user.user);
                if (user.user != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => const HomePage()),
                      (route) => false);
                } else {
                  const snakbar =
                      SnackBar(content: Text("Email or password incorrect!"));
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(snakbar);
                }
              } catch (e) {
                print(e);
                final snakbar = SnackBar(content: Text(e.toString()));
                ScaffoldMessenger.of(context).showSnackBar(snakbar);
                setState(() {
                  isLoading = false;
                });
              }
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 60,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                      colors: [primaryColor, primaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0])),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "SIGN IN",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SignupPage()),
                      (route) => false);
                },
                child: const Text(" Sign Up",
                    style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    )));
  }

  Widget SocialBtn(String text) {
    return InkWell(
      onTap: () async {
        await googleAuth.signInWithGoogle(context);
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          // color: Colors.black87,
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 1, color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/google.svg', height: 40, width: 40),
              SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextInput(String text, TextEditingController controller) {
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: TextStyle(color: Colors.black54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          style: TextStyle(color: Colors.black),
        ));
  }
}
