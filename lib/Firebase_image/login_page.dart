import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xampp_crud/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Fb_image_LoginPage extends StatefulWidget {
  const Fb_image_LoginPage({Key? key}) : super(key: key);

  @override
  State<Fb_image_LoginPage> createState() => _Fb_image_LoginPageState();
}

class _Fb_image_LoginPageState extends State<Fb_image_LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              signInWithGoogle();
            },
            child: Text('Login with Google')),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);


  }
}
