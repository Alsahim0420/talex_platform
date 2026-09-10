import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._prefs) : super(const Locale('es'));

  static const _key = 'talex.locale';
  final SharedPreferences _prefs;

  Future<void> load() async {
    final saved = _prefs.getString(_key);
    if (saved == 'en' || saved == 'es') {
      emit(Locale(saved!));
      return;
    }
    final system = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    emit(system == 'en' ? const Locale('en') : const Locale('es'));
  }

  Future<void> setLanguageCode(String code) async {
    final locale = code == 'en' ? const Locale('en') : const Locale('es');
    await _prefs.setString(_key, locale.languageCode);
    emit(locale);
  }
}
