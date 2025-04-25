import 'package:blibkit_warehouse/features/settings/domain/entity/settings_entity.dart';

abstract class SettingsRepository{
  Future<SettingsEntity> getUserProfile();
}