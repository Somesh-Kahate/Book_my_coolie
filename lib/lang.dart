import 'package:coolie/global.dart';
import 'package:coolie/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class languageSelect extends StatefulWidget {
  const languageSelect({super.key});

  @override
  State<languageSelect> createState() => _languageSelectState();
}

class _languageSelectState extends State<languageSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Choose your language'),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  langCode = 'en';
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => landingpage())));
              },
              child: Text('English')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  langCode = 'hi';
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => landingpage())));
              },
              child: Text('Hindi')),
        ],
      ),
    ));
  }
}
