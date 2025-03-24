import 'package:flutter/material.dart';
import 'package:movie_app/Screens/get_started/get_started_screen.dart';
import 'package:movie_app/screens/signup_login/signup_login_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var arrGenres = [
    'Horror',
    'Action',
    'Drama',
    'Thriller',
    'Fiction',
    'Comedy',
    'Romance',
    'Western',
    'Fantasy',
    'Animation',
    'Mystery',
    'Adventure',
    'Music',
    'Science',
    'Television',
  ];

  var selectedGenres = [];
  var genreLength = 4;

  void onTapGenre(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        if (selectedGenres.length < genreLength) {
          selectedGenres.add(genre);
        }
      }
    });
  }

  bool isGenreSelected(String genre) {
    return selectedGenres.contains(genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Text(
                    "Tell Us Your Interests!",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "Select your favorite genres",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    "to get personalised recommendation",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30),
                  child: Text(
                    "You can choose up to 4 genres.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 110,
                  mainAxisExtent: 40,
                ),
                itemCount: arrGenres.length,
                itemBuilder: (context, index) {
                  String genre = arrGenres[index];
                  bool isSelected = isGenreSelected(genre);
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 4),
                    child: GestureDetector(
                      onTap: () {
                        onTapGenre(genre);
                      },
                      child: Card(
                        color: isSelected ? Colors.deepOrange : Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            genre,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                SizedBox(
                  child: Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepOrange[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (BuildContext context) => GetStartedScreen(),
                            ),
                          );
                        },
                        child: Text("Next"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: SizedBox(
                child: Flexible(
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (BuildContext context) => SignUpLoginScreen(),
                          ),
                        );
                      },
                      child: Text("Skip"),
                    ),
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
