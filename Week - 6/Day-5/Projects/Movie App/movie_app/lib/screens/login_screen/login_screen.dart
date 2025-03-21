import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/validation/email_validation/email_validation.dart';

import '../signup_login/signup_login_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignInScreenState();
}

class SignInScreenState extends State<LogInScreen> {
  final EmailValidation _emailValidation = EmailValidation();
  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();
  final FocusNode _focus3 = FocusNode();
  final FocusNode _focus4 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpLoginScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Text(
                          "Log In\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Log into your account to start\nenjoying movies ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [Text("Email", style: TextStyle(fontSize: 18))],
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Email",
                  ),
                  validator: (value) {
                    return _emailValidation.emailValidator(value);
                  },
                  onSaved: (value) {},
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Text("Password", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.visibility_off),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Password",
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) {},
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          elevation: 10,
                          context: context,
                          builder: (BuildContext context) {
                            return FractionallySizedBox(
                              heightFactor: 1,
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        "Welcome to MovieFlix",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 30,
                                      ),
                                      child: Text(
                                        "Set 4 digit MPIN",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 60,
                                            child: Material(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              child: TextFormField(
                                                focusNode: _focus1,
                                                onChanged: (value){
                                                  if (value.isNotEmpty){
                                                    FocusScope.of(context).requestFocus(_focus2);
                                                  }
                                                },
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{1}$'))
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: "0",
                                                  contentPadding: EdgeInsets.all(8),
                                                  fillColor: Colors.black26,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.deepOrange,
                                                          width: 2,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 60,
                                            child: Material(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              child: TextFormField(
                                                focusNode: _focus2,
                                                onChanged: (value){
                                                  if (value.isNotEmpty){
                                                    FocusScope.of(context).requestFocus(_focus3);
                                                  }
                                                },
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,

                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{1}$'))
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: "0",
                                                  contentPadding: EdgeInsets.all(8),
                                                  fillColor: Colors.black26,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.deepOrange,
                                                          width: 2,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 60,
                                            child: Material(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              child: TextFormField(
                                                focusNode: _focus3,
                                                onChanged: (value){
                                                  if (value.isNotEmpty){
                                                    FocusScope.of(context).requestFocus(_focus4);
                                                  }
                                                },
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{1}$'))
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: "0",
                                                  contentPadding: EdgeInsets.all(8),
                                                  fillColor: Colors.black26,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.deepOrange,
                                                          width: 2,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 60,
                                            child: Material(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              child: TextFormField(
                                                focusNode: _focus4,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{1}$'))
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: "0",
                                                  contentPadding: EdgeInsets.all(8),
                                                  fillColor: Colors.black26,
                                                  filled: true,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(10),
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.deepOrange,
                                                          width: 2,
                                                        ),
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: FractionallySizedBox(
                                        widthFactor: 0.7,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 10,
                                            backgroundColor: Colors.deepOrange,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                          },
                                          child: Text("Save"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text("Login"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
