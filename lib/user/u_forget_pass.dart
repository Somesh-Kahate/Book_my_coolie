import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class u_forget_pass extends StatefulWidget {
  const u_forget_pass({super.key});

  @override
  State<u_forget_pass> createState() => _u_forget_passState();
}

class _u_forget_passState extends State<u_forget_pass> {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(
              //     // onPressed: () {
              //     //   FirebaseAuth.instance.signOut();
              //     //   Navigator.of(context).pushReplacement(
              //     //       MaterialPageRoute(builder: (context) => coolie_login()));
              //     },
              //     icon: Icon(Icons.logout)),
              Image.asset(
                'Assets/logo.jpg',
                fit: BoxFit.contain,
                height: 130,
                width: 120,
              ),
              Container(padding: const EdgeInsets.all(0.0))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your E-mail",
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    try {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(
                              email: _emailController.text.toString())
                          .then((value) {});
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Forgot'),
                ),
              ),
            ],
          ),
        ));
  }
}
