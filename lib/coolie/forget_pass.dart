import 'package:coolie/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forget_pass extends StatefulWidget {
  const forget_pass({super.key});

  @override
  State<forget_pass> createState() => _forget_passState();
}

class _forget_passState extends State<forget_pass> {
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
                child: TranslatedText('Forgot'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
