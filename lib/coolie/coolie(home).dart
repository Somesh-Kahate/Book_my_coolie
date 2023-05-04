import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolie/coolie/coolie_login.dart';
import 'package:coolie/user/Sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class coolie_home extends StatefulWidget {
  const coolie_home({super.key});

  @override
  State<coolie_home> createState() => _coolie_homeState();
}

class _coolie_homeState extends State<coolie_home> {
  Stream<QuerySnapshot> getPendingRideRequests() {
    return FirebaseFirestore.instance
        .collection('rides')
        .where('status', isEqualTo: 'pending')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const SideBarScreen(),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(
              //     onPressed: () {
              //       FirebaseAuth.instance.signOut();
              //       Navigator.of(context).pushReplacement(MaterialPageRoute(
              //           builder: (context) => coolie_login()));
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
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('rides').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Container();

                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading');
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['fair']),
                        subtitle: Text(data['status']),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
