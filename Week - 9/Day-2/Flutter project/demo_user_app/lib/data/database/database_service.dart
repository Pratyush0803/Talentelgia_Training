import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final CollectionReference _usersCollection =
  FirebaseFirestore.instance.collection('user');


  Future<String> addUser({
    required String userName,
    required String emailAddress,
    required String mobileNumber,
    required String userPassword,
  }) async {
    try {
      final currentTime = DateTime.now();
      final String userId = const Uuid().v1();

      await _usersCollection.doc(userId).set({
        'user_name': userName,
        'email_address': emailAddress,
        'mobile_number': mobileNumber,
        'user_password': userPassword,
        'status': false,
        'user_type_id': userId,
        'created_at': currentTime,
        'updated_at': currentTime ,
      });

      return 'Success';
    } catch (e) {
      if (kDebugMode) {
        print('AddUser Error: $e');
      }
      return 'Error adding user: ${e.toString()}';
    }
  }
  Future<String?> getUser(String userId) async {
    try {
      final snapshot = await _usersCollection.doc(userId).get();

      if (!snapshot.exists) {
        return 'User not found';
      }

      final data = snapshot.data() as Map<String, dynamic>;
      return data['user_name'];
    } catch (e) {
      if (kDebugMode) {
        print('GetUser Error: $e');
      }
      return 'Error fetching user: ${e.toString()}';
    }
  }
}
