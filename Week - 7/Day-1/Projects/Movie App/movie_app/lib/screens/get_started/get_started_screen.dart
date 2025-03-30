import 'package:flutter/material.dart';
import 'package:movie_app/screens/signup_login/signup_login_screen.dart';

class GetStartedScreen extends StatefulWidget{
  const GetStartedScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GetStartedScreenState();
}
class _GetStartedScreenState extends State<GetStartedScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text("Ready to Get Started?",
                  style:
                    TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text("Let's Watch!",
                    style:
                    TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: 0.7,
                widthFactor: 0.7,
                child: Image.asset(
                    'assets'
                        '/images'
                        '/movie.png'
                ),
              ),
            ),
            Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: SizedBox(
                    child: Flexible(
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepOrange[500],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            onPressed: (){
                              Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (BuildContext context) => SignUpLoginScreen()));
                            },
                            child: Text("Get Started")),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}