import 'package:coolie/coolie/coolie(home).dart';
import 'package:coolie/coolie/coolie_login.dart';
import 'package:coolie/coolie/coolie_reg.dart';
import 'package:coolie/global.dart';
import 'package:coolie/user/login.dart';
import 'package:coolie/user/user(home).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
// import 'package:flutter/src/widgets/container.dart';

// import 'package:translator/translator.dart';
class landingpage extends StatefulWidget {
  const landingpage({super.key});

  @override
  State<landingpage> createState() => _landingpageState();
}

class _landingpageState extends State<landingpage> {
  // List collections = [];
  // void translate()
  // {
  //   translator.translate(collections ,to : "hi").then((output)
  //   {
  //     setState((){
  //       collections.toString() =output;
  //     });
  //   });
  // }

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
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 100.0, right: 100),
              height: 250,
              width: 200,
              child: Image.asset(
                'Assets/user.jpg',
                fit: BoxFit.contain,
                height: 130,
                width: 120,
              ),
            ),
            SizedBox(height: 0),
            Container(
              margin: const EdgeInsets.only(
                  top: 0.0, bottom: 0, left: 100, right: 100),
              height: 50,
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser == null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => Login())));
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => user_home())));
                  }
                },
                child: TranslatedText('User'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
            SizedBox(height: 0),
            Container(
              margin: const EdgeInsets.only(top: 0, left: 100, right: 100),
              height: 300,
              width: 250,
              child: Image.asset(
                'Assets/bbb.webp',
                fit: BoxFit.contain,
                height: 130,
                width: 120,
              ),
            ),
            SizedBox(height: 0),
            Container(
              margin: const EdgeInsets.only(
                  top: 0, bottom: 10, left: 100, right: 100),
              height: 50,
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser == null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => coolie_login())));
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => coolie_home())));
                  }
                },
                child: TranslatedText("Coolie"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
            ),
            // TextButton(
            //   child: const TranslatedText(
            //     'Change Language',
            //       TextStyle(
            //         fontSize: 20,
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold),
            //   ),
            //   onPressed: () {
            //     setState(() {
            //       langCode = 'hi';
            //     });
            //     Navigator.pushReplacement(context,
            //         MaterialPageRoute(builder: (context) => super.widget));
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
