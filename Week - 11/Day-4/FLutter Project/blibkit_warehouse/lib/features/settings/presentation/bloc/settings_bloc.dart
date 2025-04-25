import 'package:blibkit_warehouse/features/settings/domain/usecases/get_user_settings_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetUserSettings getUserSettings;

  SettingsBloc(this.getUserSettings) : super(SettingsInitial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(SettingsLoading());
      try {
        final profile = await getUserSettings();
        emit(SettingsLoaded(profile));
      } catch (e) {
        final message = e.toString().contains("User is not logged in")
            ? "Please sign in to view your profile."
            : "Failed to load profile: ${e.toString()}";
        emit(SettingsError(message));
      }
    });
  }
}