import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

String langCode = 'en';
Future<String> translate(String translateText) async {
  var data = await translator.translate(translateText, to: langCode);
  return data.toString();
}

GoogleTranslator translator = GoogleTranslator();

Widget TranslatedText(String text) {
  return Container(
    child: FutureBuilder(
      future: translate(text),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(snapshot.data.toString());
        } else {
          return Text(" ");
        }
      }),
    ),
  );
}
