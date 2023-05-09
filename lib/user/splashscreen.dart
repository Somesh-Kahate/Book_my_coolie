import 'package:coolie/landingpage.dart';
import 'package:coolie/lang.dart';
import 'package:coolie/user/login.dart';
import 'package:coolie/user/user(home).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => languageSelect())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "Assets/logo.jpg",
            height: 200,
          ),
          const SizedBox(
            height: 30,
          ),
          const CircularProgressIndicator(
            color: Colors.white,
          )
        ],
      )),
    );
  }
}
