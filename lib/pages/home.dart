import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:worklo/pages/addtodo.dart';
import 'package:worklo/pages/signin.dart';

import '../service/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth googleAuth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WorkLo"),
        actions: [
          IconButton(
            onPressed: () async {
              try {
                await googleAuth.signoutWithGoogle();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const SigninPage()),
                    (route) => false);
              } catch (e) {
                print(e);
                final snakbar = SnackBar(content: Text(e.toString()));
                ScaffoldMessenger.of(context).showSnackBar(snakbar);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: AddTodoPage(),
    );
  }
}
