import 'package:blibkit_warehouse/features/settings/data/data_source/settings_data_source.dart';
import 'package:blibkit_warehouse/features/settings/domain/entity/settings_entity.dart';
import 'package:blibkit_warehouse/features/settings/domain/repository/settings_repository.dart';


class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDataSource settingsDataSource;

  SettingsRepositoryImpl(this.settingsDataSource);

  @override
  Future<SettingsEntity> getUserProfile() {
    return settingsDataSource.getUserProfile();
  }
}
