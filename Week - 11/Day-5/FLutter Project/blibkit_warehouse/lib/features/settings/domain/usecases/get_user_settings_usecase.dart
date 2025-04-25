import 'package:blibkit_warehouse/features/settings/domain/entity/settings_entity.dart';
import 'package:blibkit_warehouse/features/settings/domain/repository/settings_repository.dart';

class GetUserSettings{
  final SettingsRepository repository;
  GetUserSettings(this.repository);

  Future<SettingsEntity> call() => repository.getUserProfile();

}