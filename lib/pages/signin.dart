import 'package:flutter/material.dart';
import 'package:worklo/pages/signup.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign In",
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
          TextInput("Email Address"),
          const SizedBox(
            height: 15,
          ),
          TextInput("Password"),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0])),
            child: const Center(
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
              const Text("Don't have an account?",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SignupPage()),
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
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 60,
      child: Card(
        color: Colors.black,
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
    );
  }

  Widget TextInput(String text) {
    return Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 60,
        child: TextFormField(
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
