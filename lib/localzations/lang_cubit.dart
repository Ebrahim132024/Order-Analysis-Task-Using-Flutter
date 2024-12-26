import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:ordersanalysis/utils/shared.dart';


class LangCubit extends Cubit<Locale> {
  LangCubit() : super(Locale('en')){
    _loadSavedLanguage();
  }
  // Load the saved language from SharedPreferences
  Future<void> _loadSavedLanguage() async {

    final String? languageCode = prefs.getString('language_code');
    if (languageCode != null) {
      emit(Locale(languageCode));
    }
  }

  // Change the language and save it in SharedPreferences
  Future<void> changeLanguage(Locale locale, BuildContext context) async {
    context.setLocale(locale);
    emit(locale);

    await prefs.setString('language_code', locale.languageCode);
  }

  // Toggle between English and Arabic
  Future<void> toggleLanguage(BuildContext context) async {
    final newLocale = state.languageCode == 'en' ? Locale('ar') : Locale('en');
    context.setLocale(newLocale);
    emit(newLocale);


    await prefs.setString('language_code', newLocale.languageCode);
  }
}
