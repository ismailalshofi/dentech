import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../core/values/values.dart';
import 'home_screen.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int _screenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: IndexedStack(
        index: _screenIndex,
        children: [
          HomeScreen(),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.lightBackgroundColor,
      leading: const Icon(Icons.menu_rounded, color : AppColors.darkBlue),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome,",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkBlue,
                ),
              ),
              Text(
                "Dr. Omran",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkBlue,
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 5, horizontal: 18),
        ),
      ),
    );
  }
  
  
  Widget _bottomBar() {
    return CurvedNavigationBar(
      height: 60.h,
      index: _screenIndex,
      onTap: (idx) => setState(() { _screenIndex = idx;}),
      color: AppColors.lightBackgroundColor,
      buttonBackgroundColor: AppColors.blue.withOpacity(0.0),
      backgroundColor: AppColors.darkBlue,
      animationDuration : const Duration(milliseconds: 350),
      animationCurve: Curves.easeIn,
      items: [
        Icon(Icons.home , color: _screenIndex == 0 ? AppColors.white : AppColors.darkBlue),
        Icon(Icons.search, color: _screenIndex == 1 ? AppColors.white : AppColors.darkBlue),
        Icon(Icons.add, color: _screenIndex == 2 ? AppColors.white : AppColors.darkBlue),
        Icon(Icons.person, color: _screenIndex == 3 ? AppColors.white : AppColors.darkBlue),
      ],
    );
  }
}
