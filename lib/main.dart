// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:worklo/pages/home.dart';
import 'package:worklo/pages/signup.dart';
import 'package:worklo/pages/signin.dart';
import 'firebase_options.dart';
import 'service/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Widget CurrentPage = SigninPage();
  // Auth auth = Auth();

  @override
  void initState() {
    super.initState();
    check();
  }

  // void checkLogin() async {
  //   String token = await auth.getToken("token");
  //   if (token != null) {
  //     setState(() {
  //       CurrentPage = HomePage();
  //     });
  //   } else {
  //     setState(() {
  //       CurrentPage = SigninPage();
  //     });
  //   }
  // }

  Auth googleAuth = Auth();

  void check() async {
    try {
      User? currentUser = await googleAuth.checkWhetherLogedIn();
      if (currentUser != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const HomePage()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const SigninPage()),
            (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SigninPage());
  }
}
