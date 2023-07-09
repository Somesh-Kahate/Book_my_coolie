import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../global.dart';

class AdminHelp extends StatefulWidget {
  const AdminHelp({super.key});

  @override
  State<AdminHelp> createState() => _AdminHelpState();
}

class _AdminHelpState extends State<AdminHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Help').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, i) {
                Map<String, dynamic> map =
                    snapshot.data!.docs[i].data() as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialog(
                            context, snapshot.data!.docs[i].id));
                  },
                  child: HelpCard(
                    map: map,
                  ),
                );
              });
        },
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

TextEditingController solution = TextEditingController();

Widget _buildPopupDialog(BuildContext context, String? id) {
  return AlertDialog(
    title: const Text('Popup example'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: solution,
          onChanged: (val) {},
          style: const TextStyle(
            fontFamily: "SemiBold",
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            focusColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
              borderSide: BorderSide(width: 0.0, color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(width: 0.0, color: Colors.grey.shade50),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(width: 0.0, color: Colors.grey.shade50),
            ),
            filled: true,
            fillColor: Colors.black.withOpacity(0.05),
            hintText: 'Enter solution here',
            hintStyle: TextStyle(
              fontFamily: "SemiBold",
              fontSize: 14, //16,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
      ],
    ),
    actions: <Widget>[
      MaterialButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
      MaterialButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('Help')
              .doc(id)
              .update({'solution': solution.text});
          Navigator.of(context).pop();
          showToast('Solution uploaded');
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('DONE'),
      ),
    ],
  );
}
