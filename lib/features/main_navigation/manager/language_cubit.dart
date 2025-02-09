import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')); // Default language is English

  void toggleLanguage() {
    if (state == const Locale('en')) {
      emit(const Locale('ar')); // Switch to Arabic
    } else {
      emit(const Locale('en')); // Switch to English
    }
  }
}
