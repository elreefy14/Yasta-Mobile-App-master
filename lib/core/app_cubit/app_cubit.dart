import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../helper/cache_helper/cache_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  String _currentLanguage = CacheHelper.getdata(key: "lang") ?? "ar";

  String get currentLanguage => _currentLanguage;

  void changeLanguage(String language) {
    _currentLanguage = language;
    CacheHelper.saveData(
        key: "lang", value: language); // Save to cache for persistence
    emit(ChangeLanguageState(language));
  }
}
