import 'package:blibkit_warehouse/features/settings/domain/entity/settings_entity.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final SettingsEntity settingsEntity;

  SettingsLoaded(this.settingsEntity);
}

class SettingsError extends SettingsState {
  final String message;

  SettingsError(this.message);
}
