import 'dart:ui';

import 'package:coolie/coolie/coolie_login.dart';
import 'package:coolie/user/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'login.dart';

class SideBarScreen extends StatefulWidget {
  const SideBarScreen({super.key});

  @override
  State<SideBarScreen> createState() => _SideBarScreenState();
}

class _SideBarScreenState extends State<SideBarScreen> {
  final List drawerMenuListname = const [
    {
      "leading": Icon(Icons.account_circle, color: Colors.black),
      "title": "Profile",
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 1,
    },
    {
      "leading": Icon(Icons.question_mark_outlined, color: Colors.black),
      "title": "help",
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 2,
    },
    {
      "leading": Icon(Icons.settings, color: Colors.black),
      "title": "Setting",
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 3,
    },
    {
      "leading": Icon(Icons.signpost_outlined, color: Colors.black),
      "title": "Sign Out",
      "trailing": Icon(
        Icons.chevron_right,
      ),
      "action_id": 4,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 280,
        child: Drawer(
          backgroundColor: Color.fromARGB(255, 249, 249, 249),
          child: ListView(
            children: [
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://w7.pngwing.com/pngs/741/68/png-transparent-user-computer-icons-user-miscellaneous-cdr-rectangle-thumbnail.png"),
                ),
                title: Text(
                  "Somesh Kahate",
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  "someshkahate6@gmail.com",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ...drawerMenuListname.map((sideMenuData) {
                return ListTile(
                  leading: sideMenuData['leading'],
                  title: Text(
                    // style: TextStyle(color: Colors.white),
                    sideMenuData['title'],
                  ),
                  trailing: sideMenuData['trailing'],
                  onTap: () {
                    Navigator.pop(context);
                    if (sideMenuData['action_id'] == 4) {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    }
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
