import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../global.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Help').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                Map<String, dynamic> map =
                    snapshot.data!.docs[i].data() as Map<String, dynamic>;
                return HelpCard(
                  map: map,
                );
              });
        },
      ),
      floatingActionButton: Container(
        width: getWidth(context) / 1.1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: getWidth(context) * 0.5,
                height: 50,
                child: TextFormField(
                  controller: message,
                  style: const TextStyle(
                    fontFamily: "SemiBold",
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide:
                          BorderSide(width: 0.0, color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                          BorderSide(width: 0.0, color: Colors.grey.shade50),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                          BorderSide(width: 0.0, color: Colors.grey.shade50),
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.05),
                    hintText: 'Type your message here',
                    hintStyle: TextStyle(
                      fontFamily: "SemiBold",
                      fontSize: 14, //16,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('Help').add({
                    'by': FirebaseAuth.instance.currentUser!.uid,
                    'message': message.text,
                    'solution': 'null',
                    'serverTimestamp': FieldValue.serverTimestamp()
                  });
                  setState(() {
                    message.text = '';
                  });
                  showToast('Message sent');
                },
                color: Colors.blue,
                child: Text('SEND'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HelpCard extends StatefulWidget {
  final map;
  const HelpCard({super.key, this.map});

  @override
  State<HelpCard> createState() => _HelpCardState();
}

class _HelpCardState extends State<HelpCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            child: Center(
                child: widget.map['solution'] != 'null'
                    ? Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.alarm_rounded,
                        color: Colors.yellow,
                      )),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.map['message'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.map['solution'],
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 2,
                width: getWidth(context) - 48 - 32,
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          )
        ],
      ),
    );
  }
}
