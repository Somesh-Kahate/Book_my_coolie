import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../global.dart';

class CoolieDetails extends StatefulWidget {
  final id;
  const CoolieDetails({super.key, this.id});

  @override
  State<CoolieDetails> createState() => _CoolieDetailsState();
}

class _CoolieDetailsState extends State<CoolieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('rides')
              .where('coolieId', isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) return Container();
            return ListView.builder(
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> map =
                    snapshots.data!.docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  isThreeLine: true,
                  title: Text(
                      '${destiMaster[map['pickupAddress']]['Name']} - ${destiMaster[map['destinationAddress']]['Name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${map['fair']} (${map['status']})'),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('uid', isEqualTo: map['userId'])
                              .snapshots(),
                          builder: (context, snapshots1) {
                            if (!snapshots1.hasData) return Container();
                            return ListView.builder(
                              itemCount: snapshots1.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> map1 =
                                    snapshots1.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                return Text(map1['Name']);
                              },
                            );
                          }),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('rides')
                          .doc(snapshots.data!.docs[index].id)
                          .delete();
                      showToast('task Deleted');
                    },
                  ),
                  // Other user details can be displayed here
                );
              },
            );
          }),
    );
  }
}
