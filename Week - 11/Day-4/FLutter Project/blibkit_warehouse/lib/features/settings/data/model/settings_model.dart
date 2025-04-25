import 'package:blibkit_warehouse/features/settings/domain/entity/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({required super.email, required super.userImage});

  factory SettingsModel.fromFirebase(Map<String, dynamic> userData) {
    return SettingsModel(
      email: userData['email'],
      userImage: userData['userImage'],
    );
  }
}
