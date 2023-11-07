import 'package:dentech/core/app_store/app_store.dart';
import 'package:dentech/core/configure_di.dart';

class Sizer {
  static double get screenWidth  =>  getIt<AppStore>().width;
  static double get screenHeight =>  getIt<AppStore>().height;
}