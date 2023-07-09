import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolie/global.dart';
import 'package:coolie/payed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class CoolieAccepted extends StatefulWidget {
  final id;
  const CoolieAccepted({super.key, this.id});

  @override
  State<CoolieAccepted> createState() => _CoolieAcceptedState();
}

class _CoolieAcceptedState extends State<CoolieAccepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rides')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            var data = snapshot.data as DocumentSnapshot;

            if (data['status'] == 'paid') {
              return MyWidget();
            }

            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  TranslatedText("You've accepted the order!"),
                  TranslatedText('Fair(Rs.) :${data['fair']}'),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('uid', isEqualTo: data['userId'])
                          .snapshots(),
                      builder: (context, snaps) {
                        if (!snaps.hasData) return Container();
                        var map = snaps.data!.docs.first as DocumentSnapshot;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TranslatedText(
                                'From : ${destiMaster.map((e) => e).where((element) => element['ID'] == data['pickupAddress']).toList().first['Name'].toString()}'),
                            TranslatedText(
                                'To : ${destiMaster.map((e) => e).where((element) => element['ID'] == data['destinationAddress']).toList().first['Name'].toString()}'),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TranslatedText(
                                            map['Name'],
                                            TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          //TranslatedText(cooliemap['Mobile']),
                                        ],
                                      )),
                                  ElevatedButton(
                                      onPressed: () {
                                        final url =
                                            Uri.parse("tel:${map['Mobile']}");
                                        launchUrl(url);
                                      },
                                      child: TranslatedText('Call'))
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }
}
