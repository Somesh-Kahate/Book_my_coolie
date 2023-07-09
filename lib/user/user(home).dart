import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolie/global.dart';
import 'package:coolie/payed.dart';
import 'package:coolie/payment/backend.dart';
import 'package:coolie/user/Sidebar.dart';
import 'package:coolie/user/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:url_launcher/url_launcher.dart';

class user_home extends StatefulWidget {
  const user_home({super.key});

  @override
  State<user_home> createState() => _user_homeState();
}

class _user_homeState extends State<user_home> {
  List<String> bagWeights = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25"
  ];
  String? bag1Weight, bag2Weight, bag3Weight, bag4Weight;
  bool isLoading = false;
  final List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];
  String? selectedValue;
  List<dynamic> stations = [];
  List<dynamic> destiMaster = [];
  List<dynamic> desti = [];
  List<dynamic> trains = [];
  List<dynamic> trainMaster = [];
  String? stationId;
  String? destiID;
  String? dropID;
  String? trainID;
  int drop = 0;
  int des = 0;
  var costData = 1;
  void getCost() async {
    costData = await FirebaseFirestore.instance
        .collection("constants")
        .doc("OFWtCeFSOsQ1GwGEmjJl")
        .get()
        .then((value) {
      print("working ${value.data()!['cost']}");
      return value.data()!['cost'];
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCost();
    this.stations.add({"val": 1, "name": "Solapur"});
    this.stations.add({"val": 2, "name": "Nagpur"});
    this.stations.add({"val": 3, "name": "Agra"});
    this.stations.add({"val": 4, "name": "Lalitpur"});
    this.stations.add({"val": 5, "name": "Ahmadnagar"});

    this.destiMaster = [
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

    this.trainMaster = [
      {"num": 1, "label": "Hutatma Express (12157)", "Parentid": 1},
      {"num": 2, "label": "Kop Solapur Special (01407)", "Parentid": 1},
      {"num": 3, "label": "Sur Kop Special (01408)", "Parentid": 1},
      {"num": 4, "label": "Sc Pbr Special (09222)", "Parentid": 1},
      {"num": 5, "label": "Hutatma Express (12158)", "Parentid": 1},
      {"num": 6, "label": "Bbs Pune Express (12582)", "Parentid": 1},
      {"num": 7, "label": "Pune Bbs Express (12581)", "Parentid": 1},
      {"num": 8, "label": "Vskp Ltt Express (12749)", "Parentid": 1},
      {"num": 9, "label": "Ltt Vskp Superfast Express (12750)", "Parentid": 1},
      {"num": 10, "label": "Pune Gr Express (06028)", "Parentid": 1},
      {"num": 11, "label": "Jp Sur Special (09713)", "Parentid": 1},
      {"num": 12, "label": "Mumbai Mail (21028)", "Parentid": 1},
      {"num": 13, "label": "Snsi Tpj Special (06805)", "Parentid": 1},
      {"num": 1, "label": "Jbp Nir Ngp Passenger (58840)", "Parentid": 2},
      {"num": 2, "label": "Puri St Wkly Express (12743)", "Parentid": 2},
      {"num": 3, "label": "Okha Howrah Express (22905)", "Parentid": 2},
      {"num": 4, "label": "Surat Puri Express (12744)", "Parentid": 2},
      {"num": 5, "label": "Ngp Nir Jbp Passenger (58839)", "Parentid": 2},
      {"num": 6, "label": "Hte Ngp Special (08612)", "Parentid": 2},
      {"num": 7, "label": "Ngp Hatia Special (08611)", "Parentid": 2},
      {"num": 8, "label": "Ltt Puri Superfast Express (12745)", "Parentid": 2},
      {"num": 9, "label": "Snsi Hwh Superfast Express (12573)", "Parentid": 2},
      {"num": 10, "label": "Ngp Jbp Superfast Special (02159)", "Parentid": 2},
      {"num": 11, "label": "Jbp Ngp Superfast Special (02160)", "Parentid": 2},
      {"num": 12, "label": "Gr Bpl Special (01221)", "Parentid": 2},
      {"num": 13, "label": "Src Ltt Special (01222)", "Parentid": 2},
      {"num": 14, "label": "Pune Ngp Special (01022)", "Parentid": 2},
      {"num": 15, "label": "Kranti Bpl Special (07619)", "Parentid": 2},
      {"num": 1, "label": "Sc Nlr Special (07121)", "Parentid": 3},
      {"num": 2, "label": "Kahanvally Express (14020)", "Parentid": 3},
      {"num": 3, "label": "Kanhan Valle Express (14019)", "Parentid": 3},
      {"num": 4, "label": "Kota Pnbe Express (93238)", "Parentid": 3},
      {"num": 5, "label": "Nzm Pune Special (01072)", "Parentid": 3},
      {"num": 6, "label": "Jat Ned Special (02422)", "Parentid": 3},
      {"num": 7, "label": "Ru Gkp Special (07490)", "Parentid": 3},
      {"num": 8, "label": "Kota Pnbe Express (93240)", "Parentid": 3},
      {"num": 9, "label": "Ned Sgnr Superfast Express (04722)", "Parentid": 3},
      {"num": 10, "label": "Sgnr Ned Superfast Special (04721)", "Parentid": 3},
      {"num": 11, "label": "Koaa Agc Express (12319)", "Parentid": 3},
      {"num": 12, "label": "Agc Koaa Express (12320)", "Parentid": 3},
      {"num": 13, "label": "Ned Ald Special (07513)", "Parentid": 3},
      {"num": 1, "label": "Ald Ndls Superfast Special (04111)", "Parentid": 4},
      {"num": 2, "label": "Ndls Ald Superfast Special (04112)", "Parentid": 4},
      {"num": 3, "label": "Kahanvally Express (14020)", "Parentid": 4},
      {"num": 4, "label": "Kanhan Valle Express (14019)", "Parentid": 4},
      {"num": 5, "label": "Gkp Ltt Special (05041)", "Parentid": 4},
      {"num": 6, "label": "Hyb Jat Special (07021)", "Parentid": 4},
      {"num": 7, "label": "Gkp Ltt Special (05031)", "Parentid": 4},
      {"num": 8, "label": "Cnb Cstm Special (04153)", "Parentid": 4},
      {"num": 9, "label": "Punjab Mail (12138)", "Parentid": 4},
      {"num": 10, "label": "Pbh Bpl Express (12184)", "Parentid": 4},
      {"num": 1, "label": "Pune Patna Express (12149)", "Parentid": 5},
      {"num": 2, "label": "Jhelum Express (11077)", "Parentid": 5},
      {"num": 3, "label": "Maharashtra Express (11040)", "Parentid": 5},
      {"num": 4, "label": "Pune Ljn Express (11407)", "Parentid": 5},
      {"num": 5, "label": "Ljn Pune Express (11408)", "Parentid": 5},
      {"num": 6, "label": "Karnataka Express (12628)", "Parentid": 5},
      {"num": 7, "label": "Goa Express (12780)", "Parentid": 5},
      {"num": 8, "label": "Gkp Pune Express (15029)", "Parentid": 5},
      {"num": 9, "label": "Pune Gkp Express (15030)", "Parentid": 5},
      {"num": 10, "label": "Mys Bsb Express (16229)", "Parentid": 5},
    ];
  }

  String dropdownvalue = "1";

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
              //       Navigator.of(context).pushReplacement(
              //           MaterialPageRoute(builder: (context) => Login()));
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('rides')
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where('status', whereIn: ['pending', 'accepted', 'delivered'])
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              print(FirebaseAuth.instance.currentUser!.uid);

              //if (map['status'] == 'pending') return Column();
              if (snapshot.data!.docs.length == 0) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FormHelper.dropDownWidgetWithLabel(
                          context,
                          "Station",
                          "Enter Station",
                          this.stationId,
                          this.stations, (onChangedVal) {
                        this.stationId = onChangedVal;
                        print("Selected Station : $onChangedVal");
                        setState(() {
                          this.desti = this
                              .destiMaster
                              .where(
                                (stateItem) =>
                                    stateItem["ParentId"].toString() ==
                                    onChangedVal.toString(),
                              )
                              .toList();
                        });
                        this.destiID = null;
                        setState(() {
                          this.trains = this
                              .trainMaster
                              .where(
                                (stateItem) =>
                                    stateItem["Parentid"].toString() ==
                                    onChangedVal.toString(),
                              )
                              .toList();
                        });
                        this.trainID = null;
                      }, (onValidateval) {
                        if (onValidateval == null) {
                          return "Please select your station";
                        }
                        return null;
                      },
                          borderColor: Theme.of(context).primaryColorDark,
                          borderFocusColor: Theme.of(context).primaryColorLight,
                          borderRadius: 10,
                          optionValue: "val",
                          optionLabel: "name"),
                      FormHelper.dropDownWidgetWithLabel(
                        context,
                        "Boarding point",
                        " Select Boarding Point",
                        this.destiID,
                        this.desti,
                        (onChangedVal1) {
                          this.destiID = onChangedVal1;
                          setState(() {});

                          print("Selected Boarding point : $onChangedVal1");
                        },
                        (onValidateval) {
                          if (onValidateval == null) {
                            return "Please select your desired location";
                          }
                          return null;
                        },
                        borderColor: Theme.of(context).primaryColorDark,
                        borderFocusColor: Theme.of(context).primaryColorDark,
                        borderRadius: 10,
                        optionValue: "ID",
                        optionLabel: "Name",
                      ),
                      FormHelper.dropDownWidgetWithLabel(
                        context,
                        "Dropping point",
                        "Select dropping Point",
                        this.dropID,
                        this.desti,
                        (onChangedVal2) {
                          print(onChangedVal2.runtimeType);

                          this.dropID = onChangedVal2;
                          setState(() {});
                          // setState(() {
                          //   drop = int.parse(onChangedVal);
                          // });
                          print(
                              "Selected Dropping point : $onChangedVal2   $dropID");
                        },
                        (onValidateval) {
                          if (onValidateval == null) {
                            return "Please select your desired location";
                          }
                          return null;
                        },
                        borderColor: Theme.of(context).primaryColorDark,
                        borderFocusColor: Theme.of(context).primaryColorDark,
                        borderRadius: 10,
                        optionValue: "ID",
                        optionLabel: "Name",
                      ),
                      FormHelper.dropDownWidgetWithLabel(
                        context,
                        "Trains",
                        "Select train",
                        this.trainID,
                        this.trains,
                        (onChangedVal) {
                          this.trainID = onChangedVal;
                          print("Selected train : $onChangedVal");
                        },
                        (onValidateval) {
                          if (onValidateval == null) {
                            return "Please select your train";
                          }
                          return null;
                        },
                        borderColor: Theme.of(context).primaryColorDark,
                        borderFocusColor: Theme.of(context).primaryColorDark,
                        borderRadius: 10,
                        optionValue: "num",
                        optionLabel: "label",
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Coach Number',
                                prefixIcon: Icon(Icons.confirmation_number),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter seat number',
                                prefixIcon: Icon(Icons.confirmation_number),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          TranslatedText(
                            "    Select No. of bags         ",
                            TextStyle(fontSize: 20),
                          ),
                          DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: TranslatedText(value.toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue ?? "1";
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TranslatedText(
                          "Select approximate weight ( in kg ) of atleast 4 bags",
                          TextStyle(fontSize: 16)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TranslatedText("Bag 1", TextStyle(fontSize: 14)),
                          TranslatedText("Bag 2", TextStyle(fontSize: 14)),
                          TranslatedText("Bag 3", TextStyle(fontSize: 14)),
                          TranslatedText("Bag 4", TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton(
                            value: bag1Weight,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: bagWeights.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: TranslatedText(value.toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                bag1Weight = newValue ?? "1";
                              });
                            },
                          ),
                          DropdownButton(
                            value: bag2Weight,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: bagWeights.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: TranslatedText(value.toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                bag2Weight = newValue ?? "1";
                              });
                            },
                          ),
                          DropdownButton(
                            value: bag3Weight,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: bagWeights.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: TranslatedText(value.toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                bag3Weight = newValue ?? "1";
                              });
                            },
                          ),
                          DropdownButton(
                            value: bag4Weight,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: bagWeights.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: TranslatedText(value.toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                bag4Weight = newValue ?? "1";
                              });
                            },
                          ),
                        ],
                      ),
                      TranslatedText(
                          "Expected Estimate: ${((costData) * (int.parse(destiID ?? "1") - int.parse(dropID ?? "1")).abs() + int.parse(dropdownvalue) * 20) - costData} "),
                      TranslatedText(
                          "print: ${int.parse(bag1Weight ?? "1") + int.parse(bag2Weight ?? "1") + int.parse(bag3Weight ?? "1") + int.parse(bag4Weight ?? "1")}"),
                      SizedBox(height: 20),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            //await Future.delayed(const Duration(seconds: 20));
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
                            await FirebaseFirestore.instance
                                .collection('rides')
                                .add({
                              'pickupAddress': int.parse(this.destiID!),
                              'destinationAddress': int.parse(this.dropID!),
                              'fair':
                                  "${((costData) * (int.parse(destiID ?? "1") - int.parse(dropID ?? "1")).abs() + int.parse(dropdownvalue) * 20) - costData}",
                              'status': 'pending',
                              'userId': currentUser!.uid,
                              'timestamp': FieldValue.serverTimestamp()
                            });
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: (isLoading)
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1.5,
                                  ))
                              : TranslatedText("Book Coolie")),
                    ],
                  ),
                );
              } else {
                var map = snapshot.data!.docs.first as DocumentSnapshot;
                if (map['status'] == 'paid') {
                  return MyWidget();
                }
                if (map['status'] == 'delivered') {
                  //pay(context, map['fair'], map.id);
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        TranslatedText('Payment Pending..'),
                        ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('rides')
                                  .doc(map.id)
                                  .update({'status': 'delivered'});
                              pay(context, map['fair'], map.id);
                            },
                            child: TranslatedText('Pay'))
                      ],
                    ),
                  );
                }
                if (map['status'] == 'accepted' ||
                    (map['status'] == 'delivered' &&
                        map['paymentStatus'] == 'CREATED')) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        TranslatedText('Coolie has accepted your request'),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('coolie')
                                .where('uid', isEqualTo: map['coolieId'])
                                .snapshots(),
                            builder: (context, snaps) {
                              if (!snaps.hasData) return Container();
                              var cooliemap =
                                  snaps.data!.docs.first as DocumentSnapshot;
                              return Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TranslatedText(
                                                    cooliemap['Name']),
                                                TranslatedText(
                                                    cooliemap['station']),
                                                //TranslatedText(cooliemap['Mobile']),
                                              ],
                                            )),
                                        ElevatedButton(
                                            onPressed: () {
                                              final url = Uri.parse(
                                                  "tel:${cooliemap['Mobile']}");
                                              launchUrl(url);
                                            },
                                            child: TranslatedText('Call'))
                                      ],
                                    ),
                                  )
                                ],
                              );
                            }),
                        TranslatedText(
                            'From : ${destiMaster.map((e) => e).where((element) => element['ID'] == map['pickupAddress']).toList().first['Name'].toString()}'),
                        TranslatedText(
                            'To : ${destiMaster.map((e) => e).where((element) => element['ID'] == map['destinationAddress']).toList().first['Name'].toString()}'),
                        TranslatedText('Your fair(Rs.) : ${map['fair']}'),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TranslatedText(
                                  'Has Coolie completed the delivery? '),
                              ElevatedButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('rides')
                                        .doc(map.id)
                                        .update({'status': 'delivered'});
                                    pay(context, map['fair'], map.id);
                                  },
                                  child: TranslatedText('Yes'))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularProgressIndicator(),
                      TranslatedText(
                          'Waiting for coolie to accept the request'),
                      TranslatedText(
                          'From : ${destiMaster.map((e) => e).where((element) => element['ID'] == map['pickupAddress']).toList().first['Name'].toString()}'),
                      TranslatedText(
                          'To : ${destiMaster.map((e) => e).where((element) => element['ID'] == map['destinationAddress']).toList().first['Name'].toString()}'),
                      TranslatedText('Your fair(Rs.) : ${map['fair']}')
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
// void sendRideRequest(
//       String pickupAddress, String destinationAddress, double fair) async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     await FirebaseFirestore.instance.collection('rides').add({
//       'pickupAddress': 
//       'destinationAddress': destinationAddress
//       'fair': 
//       'status': 'pending',
//       'userId': currentUser.uid,
//     });
//   }