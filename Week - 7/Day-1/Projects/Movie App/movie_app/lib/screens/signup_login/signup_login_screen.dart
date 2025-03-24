import 'package:flutter/material.dart';
import 'package:movie_app/screens/login_screen/login_screen.dart';
import 'package:movie_app/signin_with_google/google_signin.dart';

import '../signup_screen/signup_screen.dart';

class SignUpLoginScreen extends StatefulWidget {
  const SignUpLoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpLoginScreenState();
}

class SignUpLoginScreenState extends State<SignUpLoginScreen> {
  final GoogleSignInOption _googleSignInOption = GoogleSignInOption();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //This is the image
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.asset('assets/images/movie_genres_img.jpeg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),

                //White container position
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  //This is container
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0,-5),
                          spreadRadius: 50,
                          blurRadius: 40
                        )
                      ]
                    ),
                    padding: const EdgeInsets.only(),
                    //This is the column
                    child: Column(
                     mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          child: Flexible(
                            child: Center(
                              child: Text("A World of Movies\n Free on MovieFlix",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                        //This is the Sign Up button
                        SizedBox(
                          child: Flexible(
                              child: FractionallySizedBox(
                                widthFactor: 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.deepOrange[500],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                      onPressed: (){
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                          builder: (context)=> SignUpScreen()));
                                      },
                                      child: Text("Sign Up")
                                  ),
                                ),
                              )
                          ),
                        ),

                        //This is or Text
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("or",
                            style: TextStyle(
                              fontSize: 20,
                                color: Colors.grey),
                          ),
                        ),

                        //This is Continue with google button
                        SizedBox(
                          child: Flexible(
                            child: FractionallySizedBox(
                              widthFactor: 0.7,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: OutlinedButton.icon(
                                  icon: Image.asset('assets/images/google.png'),
                                  onPressed: () async{
                                    await _googleSignInOption.signInWithGoogle();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                  label: Text("Continue with Google"),
                                ),
                              ),
                            ),
                          ),
                        ),


                        //This is the row of login and skip text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Login text
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> LogInScreen()));
                              },
                              child: Text("Login",
                                style: TextStyle(
                                    color: Colors.deepOrange[500],
                                    fontWeight: FontWeight.w500),
                              ),
                            ),

                            Text("|",style: TextStyle(color: Colors.black),),

                            //skip text
                            TextButton(
                              onPressed: () {

                              },
                              child: Text("Skip",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("By proceeding you to our",
                                style: TextStyle(
                                    color: Colors.black),
                              ),

                              //Padding of row Privacy and Policy
                              Padding(
                                padding: const EdgeInsets.only(left: 3),
                                child: Text("Terms of Use",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.deepOrange[500],
                                        color: Colors.deepOrange[500]
                                    ),
                                  ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 3,),
                                child: Text("and",style: TextStyle(
                                  color: Colors.black
                                ),),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text("Privacy Policy",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.deepOrange[500],
                              color: Colors.deepOrange[500]
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
