import 'package:flutter/foundation.dart';

class Printer {
  static void printl(String text) {
    if (kDebugMode) {

    }
  }

  static void printWarning(String text) {
    if (kDebugMode) {
      print('\x1B[33m$text\x1B[0m');
    }
  }

  static void printError(String text) {
    if (kDebugMode) {
      print('\x1B[31m$text\x1B[0m');
    }
  }

  static void printNormal(String text) {
    if (kDebugMode) {
      print('\x1B[36m$text\x1B[0m');
    }
  }

  static void printDone(String text) {
    if (kDebugMode) {
      print('\x1B[32m$text\x1B[0m');
    }
  }
}
