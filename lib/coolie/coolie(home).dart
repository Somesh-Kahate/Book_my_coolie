import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolie/coolie/accepted.dart';
import 'package:coolie/coolie/coolie_login.dart';
import 'package:coolie/global.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool? loading = false;

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
                stream: FirebaseFirestore.instance
                    .collection('rides')
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return Container();

                  if (snapshot.hasError) {
                    return TranslatedText('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return TranslatedText('Loading');
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      if (data['status'] == 'accepted') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CoolieAccepted(
                                  id: document.id,
                                )));
                        return Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TranslatedText('Fair(Rs.) :${data['fair']}'),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .where('uid', isEqualTo: data['userId'])
                                      .snapshots(),
                                  builder: (context, snaps) {
                                    if (!snaps.hasData) return Container();
                                    var map = snaps.data!.docs.first
                                        as DocumentSnapshot;
                                    return Column(
                                      children: [
                                        TranslatedText(map['Name']),
                                        TranslatedText(
                                            'From : ${destiMaster.map((e) => e).where((element) => element['ID'] == data['pickupAddress']).toList().first['Name'].toString()}'),
                                        TranslatedText(
                                            'To : ${destiMaster.map((e) => e).where((element) => element['ID'] == data['destinationAddress']).toList().first['Name'].toString()}'),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                          subtitle: TranslatedText(data['status']),
                          trailing: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                await FirebaseFirestore.instance
                                    .collection('rides')
                                    .doc(document.id)
                                    .update({
                                  'status': 'accepted',
                                  'coolieId':
                                      FirebaseAuth.instance.currentUser!.uid
                                });
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CoolieAccepted(id: document.id)));
                                setState(() {
                                  loading = false;
                                });
                              },
                              child: TranslatedText('Accept')),
                        ),
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
