import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLocaleController extends GetxController{
  void changeLanguage(languageCode){
    Locale locale = Locale.fromSubtags(languageCode: languageCode);
    Get.updateLocale(locale);
  }
}