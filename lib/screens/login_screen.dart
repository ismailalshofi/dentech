import 'package:dentech/core/utils/extensions/context_extensions.dart';
import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:dentech/core/utils/sizer.dart';
import 'package:dentech/core/values/values.dart';
import 'package:dentech/core/widgets/empty_widget.dart';
import 'package:dentech/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Empty(),
                const Empty(),
                Column(
                  children: [
                    Image(
                      image: const AssetImage("assets/images/blue_logo.png"),
                      fit: BoxFit.cover,
                      height: 75.h,
                    ).paddingBottom(20),
                    Text(
                      "DENTECH",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontFamily: 'Audiowide',
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBlue,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 1.seconds).then(delay: 500.milliseconds),
                _formWidget().animate().fadeIn(duration: 1.seconds).then(delay: 200.ms),
                const Empty()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _formWidget() {
    return Form(
      child: Column(
        children: [
          _textField("mobile number"),
          _textField("password"),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _textField(String hintText) {
    return Container(
      height: 45.h,
      width: 320.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.lightBackgroundColor,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(15),
          hintStyle: TextStyle(
            color: AppColors.black.withOpacity(0.37),
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
      ),
    ).paddingSymmetric(vertical: 5);
  }

  Widget _submitButton() {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      },
      child: Container(
        height: 45.h,
        width: 130.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.blue,
        ),
        child: Center(
          child: Text(
            "Login",
            style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp),
          ),
        ),
      ).paddingSymmetric(vertical: 10),
    );
  }
}
