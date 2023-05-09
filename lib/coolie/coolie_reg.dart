import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolie/coolie/coolie_login.dart';
import 'package:coolie/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import 'package:dropdownfield/dropdownfield.dart';

class CoolieR extends StatefulWidget {
  const CoolieR({super.key});

  @override
  State<CoolieR> createState() => _CoolieRState();
}

class _CoolieRState extends State<CoolieR> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate() {
    if (formkey.currentState!.validate()) {
      print('Ok');
    } else {
      print('error');
    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _stationnameController = TextEditingController();
  // bool _isVisible = false;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmpasswordController.dispose();
    _mobileNoController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    if (_passwordController.text.toString() ==
        _confirmpasswordController.text.toString()) {
      return true;
    } else {
      return false;
    }
  }

  Future SignUp() async {
    //authenticate user
    if (passwordConfirmed()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passwordController.text.toString())
          .then((value) {
        print("Account created");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => coolie_login()));
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
    }
  }

  // String dropdownvalue = 'Select Station';
  // var items = [
  //   'Select Station',
  //   'Nagpur',
  //   'Agra',
  //   'Lalitpur',
  //   'Jalna',
  //   'Ahmadnagar'
  // ];
  String _password = '';
  String _confirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TranslatedText(
              'Coolie SignUp',
              TextStyle(
                  fontFamily: 'Satisfy',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 50,
                      //   width: 130,
                      //   child: Container(
                      //     color: Colors.white,
                      //     child: DropdownButton(
                      //       value: dropdownvalue,
                      //       dropdownColor: Colors.white,
                      //       icon: Icon(Icons.arrow_drop_down,
                      //           color: Colors.black),
                      //       items: items.map((String items) {
                      //         return DropdownMenuItem(
                      //           value: items,
                      //           child: TranslatedText(
                      //             items,
                      //               TextStyle(color: Colors.black),
                      //           ),
                      //         );
                      //       }).toList(),
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           dropdownvalue = newValue!;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _stationnameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Enter Station  Name',
                            hintText: 'Station name ',
                            prefixIcon: Icon(Icons.text_fields),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Enter your Name',
                            hintText: 'Name',
                            prefixIcon: Icon(Icons.text_fields),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _mobileNoController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Mobile No.',
                            hintText: 'Enter Your Mobile No.',
                            prefixIcon: Icon(Icons.call),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String) {},
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: 'Required'),
                              MinLengthValidator(10,
                                  errorText: 'Mininmun 10 numbers are required')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: ' Email',
                            hintText: 'Enter Your Email.',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String) {},
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: 'Required'),
                              EmailValidator(errorText: 'Not correct email')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            _password = value;
                          },
                          validator: MultiValidator(
                            [
                              RequiredValidator(errorText: 'Required'),
                              MinLengthValidator(6,
                                  errorText:
                                      'Mininmun 6 characters are required')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                            controller: _confirmpasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: 'Confirm Password',
                              prefixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              _confirmPassword = value;
                            },
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Conform password is required please enter';
                              }
                              if (value != _password) {
                                return 'Confirm password not matching';
                              }
                              return null;
                            }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 0),
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text.toString(),
                                    password:
                                        _passwordController.text.toString())
                                .then((value) {
                              FirebaseFirestore.instance
                                  .collection('coolie')
                                  .add({
                                'Name': _nameController.text,
                                'Mobile': _mobileNoController.text,
                                'station': _stationnameController.text
                              });
                              print("Account created");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => coolie_login()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                            // FirebaseFirestore.instance
                            //     .collection('coolie')
                            //     .add({
                            //   'Name': _nameController.text,
                            //   'Mob.No': _MobileNoController.text,
                            //   "station": _stationnameController
                            // });
                          },
                          child: TranslatedText('Sign Up'),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
