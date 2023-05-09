import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

String langCode = 'en';
Future<String> translate(String translateText) async {
  var data = await translator.translate(translateText, to: langCode);
  return data.toString();
}

GoogleTranslator translator = GoogleTranslator();

Widget TranslatedText(String text, [TextStyle? style]) {
  return Container(
    child: FutureBuilder(
      future: translate(text),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data.toString(),
            style: style,
          );
        } else {
          return Text(" ", style: style);
        }
      }),
    ),
  );
}

List<Map<String, dynamic>> destiMaster = [
  {"ID": 1, "Name": "Main Gate", "ParentId": 1},
  {"ID": 2, "Name": "Platform 1", "ParentId": 1},
  {"ID": 3, "Name": "Platform 2", "ParentId": 1},
  {"ID": 4, "Name": "Platform 3", "ParentId": 1},
  {"ID": 5, "Name": "Platform 4", "ParentId": 1},
  {"ID": 1, "Name": "Main Gate", "ParentId": 2},
  {"ID": 2, "Name": "Platform 1", "ParentId": 2},
  {"ID": 3, "Name": "Platform 2", "ParentId": 2},
  {"ID": 4, "Name": "Platform 3", "ParentId": 2},
  {"ID": 5, "Name": "Platform 4", "ParentId": 2},
  {"ID": 6, "Name": "Platform 5", "ParentId": 2},
  {"ID": 7, "Name": "Platform 6", "ParentId": 2},
  {"ID": 8, "Name": "Platform 7", "ParentId": 2},
  {"ID": 9, "Name": "Platform 8", "ParentId": 2},
  {"ID": 10, "Name": "Back Gate ( Cotton Market)", "ParentId": 2},
  {"ID": 1, "Name": "Main Gate ", "ParentId": 3},
  {"ID": 2, "Name": "Platform 1", "ParentId": 3},
  {"ID": 3, "Name": "Platform 2", "ParentId": 3},
  {"ID": 4, "Name": "Platform 3", "ParentId": 3},
  {"ID": 5, "Name": "Platform 4", "ParentId": 3},
  {"ID": 6, "Name": "Platform 5", "ParentId": 3},
  {"ID": 7, "Name": "Platform 6", "ParentId": 3},
  {"ID": 1, "Name": "Main Gate", "ParentId": 4},
  {"ID": 2, "Name": "Platform 1", "ParentId": 4},
  {"ID": 3, "Name": "Platform 2", "ParentId": 4},
  {"ID": 4, "Name": "Platform 3", "ParentId": 4},
  {"ID": 1, "Name": "Main Gate", "ParentId": 5},
  {"ID": 2, "Name": "Platform 1", "ParentId": 5},
  {"ID": 3, "Name": "Platform 2", "ParentId": 5},
];
