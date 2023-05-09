import 'package:coolie/global.dart';
import 'package:coolie/user/User_registration.dart';
import 'package:coolie/user/u_forget_pass.dart';
import 'package:coolie/user/user(home).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate() {
    if (formkey.currentState!.validate()) {
      print('Ok');
    } else {
      print('error');
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: TranslatedText(
              'User Login',
              TextStyle(
                  fontSize: 40,
                  fontFamily: 'Satisfy',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.password),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => u_forget_pass()));
            },
            child:  TranslatedText(
              'Forgot Password',
              TextStyle(color: Colors.black),
            ),
          ),
          Container(
            height: 50,
            padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, foregroundColor: Colors.white),
              onPressed: () {
                try {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim())
                      .then((value) => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => user_home())));
                } catch (e) {
                  print(e);
                }
              },
              child: TranslatedText('Login'),
            ),
          ),
          Row(
            children: <Widget>[
               TranslatedText('Does not have account?'),
              TextButton(
                child:  TranslatedText(
                  'Sign up',
                  TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => user_r()));
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
