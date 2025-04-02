import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List movies = [];
  final Dio dio = Dio();

  Future<void> fetchData() async {
    final url = 'http://192.168.0.162:3000/movies';
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          movies = response.data;
        });
      } else {
        throw Exception("Failed to load user data");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Dio error: ${e.message}");
      }
    }
  }

  void addData() async {
    final url = 'http://192.168.0.162:3000/movies';
    try {
      final response = await dio.post(
        url,
        data: {
          "Title": "One Piece",
          "Year": "1999",
          "Genre": "Anime",
          "Writer": "Eiichiro Oda",
          "Director": "Kōnosuke Uda, Junji Shimizu, Munehisa Sakai, Hiroaki Miyamoto, Toshinori Fukazawa, "
              "Tatsuya Nagamine, Kōhei Kureta, Aya Komaki, Satoshi Itō, and Yasunori Koyama",
          "Actors": "Monkey D. Luffy, Roronoa Zoro, Sanji, Nico Robin,"
              " Nami, Brook, Jimbei,"
              " Tony Tony Chopper, Franky, and Usopp",
          "Poster": "https://upload.wikimedia.org/wikipedia/en/9/90/One_Piece%2C_Volume_61_Cover_%28Japanese%29.jpg",
          "Plot" : "Monkey D. Luffy's journey to become the King of Pirates and find the legendary treasure, One Piece,"
              " after eating a Devil Fruit that grants him rubber-like abilities, as he assembles a crew known as the Straw Hats."
        },
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        print("Dio Error: ${e.message}");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
          onPressed: addData,
          child: Icon(Icons.add,size: 35)
      ),
      appBar: AppBar(
        title: Text("Dio API"),
        backgroundColor: Colors.cyanAccent,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Genres",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Movies",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Image.network(
                        movies[index]['Poster'],
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "All Movies",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 80,
                            child: Image.network(movies[index]['Poster']),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      movies[index]['Title'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "Writer: ${movies[index]['Writer']}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "Director: ${movies[index]['Director']}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "Actors: ${movies[index]['Actors']}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      "Genre: ${movies[index]['Genre']}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
