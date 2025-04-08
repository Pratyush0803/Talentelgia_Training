import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return ListView.builder(
            itemCount: streamSnapshot.data?.docs.length,
            itemBuilder:
                (context, index) => SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(streamSnapshot.data?.docs[index]['user_name']),
                          Text(
                            streamSnapshot.data?.docs[index]['email_address'],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }
}
