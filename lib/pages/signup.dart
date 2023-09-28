import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:worklo/pages/signin.dart';

import '../service/auth.dart';
import 'home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          SocialBtn("Continue with Google"),
          // const SizedBox(
          //   height: 10,
          // ),
          // SocialBtn("Continue with Mobile"),
          const SizedBox(
            height: 30,
          ),
          const Text("or", style: TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(
            height: 30,
          ),
          TextInput("Email Address", emailController),
          const SizedBox(
            height: 15,
          ),
          TextInput("Password", passwordController),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () async {
              try {
                setState(() {
                  isLoading = true;
                });
                firebase_auth.UserCredential user =
                    await auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                if (user.user!.email != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage(),
                    ),
                    (route) => false,
                  );
                } else {
                  const snakbar = SnackBar(
                      content: Text(
                          "Please verify your email address before login"));
                  ScaffoldMessenger.of(context).showSnackBar(snakbar);
                }
              } catch (e) {
                final snakbar = SnackBar(content: Text(e.toString()));
                ScaffoldMessenger.of(context).showSnackBar(snakbar);
              } finally {
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
                      colors: [Colors.blue, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0])),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Sign Up",
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
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SigninPage()),
                      (route) => false);
                },
                child: const Text(" Sign In",
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 159, 250),
                        fontWeight: FontWeight.bold)),
              ),
            ],
          )
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
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: Card(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: Colors.white)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
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
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ));
  }
}
