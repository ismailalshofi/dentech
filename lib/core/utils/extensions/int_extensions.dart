import 'package:flutter/material.dart';
import '../../configure_di.dart';
import '../../app_store/app_store.dart';

extension IntExtensions on int {
  int validate({int value = 0}) => this;
  bool isSuccessful() => this >= 200 && this <= 206;

  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble());

  Duration get microseconds => Duration(microseconds: validate());
  Duration get milliseconds => Duration(milliseconds: validate());
  Duration get seconds => Duration(seconds: validate());
  Duration get minutes => Duration(minutes: validate());
  Duration get hours => Duration(hours: validate());
  Duration get days => Duration(days: validate());


  double get h => ((this * getIt<AppStore>().height) / getIt<AppStore>().defaultHeight);

  double get w => ((this * getIt<AppStore>().width) / getIt<AppStore>().defaultWidth);


  double get sp =>
      ((getIt<AppStore>().width * getIt<AppStore>().height) * this) /
          (getIt<AppStore>().defaultHeight * getIt<AppStore>().defaultWidth);
}
