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

  // @override
  // void initState() {
  //   super.initState();
  //   checkLogin();
  // }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SigninPage());
  }
}
