import 'package:firebase_auth/firebase_auth.dart';
import '../model/settings_model.dart';

class SettingsDataSource {
  final FirebaseAuth firebaseAuth;

  SettingsDataSource(this.firebaseAuth);

  Future<SettingsModel> getUserProfile() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("User is not logged in. Please sign in again.");
    }

    return SettingsModel(
      email: user.email ?? "No email",
      userImage: user.photoURL ?? "",
    );
  }
}