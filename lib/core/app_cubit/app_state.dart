part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}


class ChangeLanguageState extends AppState {
  final String language;
  ChangeLanguageState(this.language);
}

