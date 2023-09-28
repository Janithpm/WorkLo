import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../pages/home.dart';

class Auth {
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  // final storage = FlutterSecureStorage();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // await storeTokens(userCredential);

        print(userCredential.user!.displayName);

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const HomePage()),
            (route) => false);
      } else {
        const snakbar = SnackBar(
            content: Text("Something when wrong, please try again later."));
        ScaffoldMessenger.of(context).showSnackBar(snakbar);
      }
    } catch (e) {
      final snakbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    }
  }

  Future<void> signoutWithGoogle() async {
    await _googleSignIn.signOut();
  }

  // Future<void> storeTokens(UserCredential userCredential) async {
  //   await storage.write(
  //       key: "token", value: userCredential.credential!.token.toString());
  //   await storage.write(
  //       key: "accessToken", value: userCredential.credential!.accessToken);
  //   await storage.write(
  //     key: "userCredential",
  //     value: userCredential.toString(),
  //   );
  // }

  // Future<String> getToken(String key) async {
  //   return await storage.read(key: key).toString();
  // }

  Future<User?> checkWhetherLogedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }
}
