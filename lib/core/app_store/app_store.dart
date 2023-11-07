import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dentech/core/local/languages/language_ar.dart';
import 'package:dentech/core/utils/extensions/int_extensions.dart';
import '../../main.dart';
import '../data/local_data/shared_pref.dart';
import '../local/app_localization.dart';
import '../local/language_data_model.dart';
import '../local/languages/language_en.dart';
import 'dart:ui' as ui;
import '../utils/functions.dart';
import '../values/constant.dart';

late SharedPreferences sharedPreferences;

LanguageDataModel? selectedLanguageDataModel;
List<LanguageDataModel> localeLanguageList = [];

Color defaultToastBackgroundColor = Colors.grey.shade200;
Color defaultToastTextColor = Colors.black;
ToastGravity defaultToastGravityGlobal = ToastGravity.CENTER;

Duration pageRouteTransitionDurationGlobal = 400.milliseconds;

class AppStore {
  bool isDarkMode = false;

  String selectedLanguageCode = ui.window.locale.languageCode;

  final double defaultWidth = 360;
  final double defaultHeight = 690;

  double width = 0;
  double height = 0;

  initial() async{
    sharedPreferences = await SharedPreferences.getInstance();

    Size screenSize = MediaQueryData.fromView(PlatformDispatcher.instance.implicitView!).size;
    Orientation orientation = MediaQueryData.fromView(PlatformDispatcher.instance.implicitView!).orientation;

    if (orientation == Orientation.portrait) {
      width = screenSize.width;
      height = screenSize.height;
    } else {
      width = screenSize.height;
      height = screenSize.width;
    }
    Printer.printDone("=> Done adding device size .");

    selectedLanguageCode = getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: PlatformDispatcher.instance.locale.languageCode);
    selectedLanguageCode == "en"
        ? language = LanguageEn()
        : language = LanguageAr();
    Printer.printDone("=> Done adding device language .");

    int themeIndex = getIntAsync(THEME_MODE_INDEX, defaultValue: 0);
    isDarkMode = isDarkMode = themeIndex == 1
        ? false
        : themeIndex == 2
            ? true
            : PlatformDispatcher.instance.platformBrightness.name == "dark";
    Printer.printDone("=> Done adding device theme .");
  }

  Future<void> setDarkMode(int themeIndex) async {
    isDarkMode = themeIndex == 1
        ? false
        : themeIndex == 2
            ? true
            : PlatformDispatcher.instance.platformBrightness.name == "dark";
  }

  Future<void> setLanguage(String val) async {
    selectedLanguageCode = val;
    //TODO : remove after testing
    selectedLanguageDataModel =
        getSelectedLanguageModel(defaultLanguage: selectedLanguageCode);

    language = await const AppLocalizations().load(Locale(selectedLanguageCode));
  }
}
