import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolie/global.dart';
import 'package:coolie/user/login.dart';
import 'package:coolie/user/user(home).dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

class user_r extends StatefulWidget {
  const user_r({super.key});

  @override
  State<user_r> createState() => _user_rState();
}

class _user_rState extends State<user_r> with SingleTickerProviderStateMixin {
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

  // bool _isVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmpasswordController.dispose();
    _mobileNoController.dispose();
    super.dispose();
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
            context, MaterialPageRoute(builder: (context) => Login()));
      }).onError((error, stackTrace) {
        print("Error ${error.toString()}");
      });
      // addUserDetails(
      //   _nameController.text.toString(),
      //   _MobileNoController.text.trim(),
      // );
    }
  }

  //add details of user
  // Future addUserDetails(String name, String MobNo) async {
  //   await FirebaseFirestore.instance.collection('users').add({
  //     'Name': name,
  //     'MobNo': MobNo,
  //   });
  // }

  bool passwordConfirmed() {
    if (_passwordController.text.toString() ==
        _confirmpasswordController.text.toString()) {
      return true;
    } else {
      return false;
    }
  }

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
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 100),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TranslatedText(
                'User SignUp',
                TextStyle(
                    fontFamily: 'Satisfy',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Form(
                  //autovalidateMode: AutovalidateMode.always,
                  key: formkey,

                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Name',
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
                            labelText: 'Email',
                            hintText: 'Enter Your Email_id.',
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
                      //SizedBox(height: 10),
                      // SizedBox(
                      //   height: 60,
                      //   child: TextFormField(
                      //     keyboardType: TextInputType.text,
                      //     decoration: InputDecoration(
                      //       labelText: 'UserID',
                      //       hintText: 'Create Your UserID',
                      //       prefixIcon: Icon(Icons.text_fields),
                      //       border: OutlineInputBorder(),
                      //     ),
                      //     onChanged: (String) {},
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'required';
                      //       } else {
                      //         return null;
                      //       }
                      //     },
                      //   ),
                      // ),
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
                          onChanged: (String) {},
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
                            labelText: 'Confirm password',
                            hintText: 'Confirm password',
                            prefixIcon: Icon(Icons.password),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String) {},
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
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          /*if (_passwordController.text.toString()==
                              _confirmpasswordController.text.toString()) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text.toString(),
                                    password:
                                        _passwordController.text.toString())
                                .then((value) {
                              print("Account created");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                            // addUserDetails(
                            //   _nameController.text.toString(),
                            //   _MobileNoController.text.trim(),
                            // );
                          }*/
                          // await FirebaseAuth.instance
                          //     .createUserWithEmailAndPassword(
                          //         email: _emailController.text.toString(),
                          //         password: _passwordController.text.toString())
                          //     .then((value) {
                          //   print("Account created");
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => Login()));
                          // }).onError((error, stackTrace) {
                          //   print("Error ${error.toString()}");
                          // });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0, bottom: 0),
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () async {
                              /*if (_passwordController.text.toString()==
                              _confirmpasswordController.text.toString()) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text.toString(),
                                    password:
                                        _passwordController.text.toString())
                                .then((value) {
                              print("Account created");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                            // addUserDetails(
                            //   _nameController.text.toString(),
                            //   _MobileNoController.text.trim(),
                            // );
                          }*/
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailController.text.toString(),
                                      password:
                                          _passwordController.text.toString())
                                  .then((value) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .add({
                                  'Name': _nameController.text,
                                  'Mobile': _mobileNoController.text,
                                });
                                print("Account created");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              }).onError((error, stackTrace) {
                                print("Error ${error.toString()}");
                              });
                            },
                            child: TranslatedText('Sign Up'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
