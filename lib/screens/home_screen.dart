import 'package:dentech/core/utils/extensions/context_extensions.dart';
import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:dentech/core/values/values.dart';
import 'package:dentech/widgets/visit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/widgets/empty_widget.dart';

class HomeScreen extends StatelessWidget {
  List categoriesData = [
    {
      "name": "Visits",
      "icon": "assets/icons/teeth.svg",
    },
    {
      "name": "Patients",
      "icon": "assets/icons/patient.svg",
    },
    {
      "name": "Statistics",
      "icon": "assets/icons/bar.svg",
    },
    {
      "name": "Schedule",
      "icon": "assets/icons/calander.svg",
    },
  ];

  List visits = [
    {
      "name": "Amr Narch",
      "icon": "assets/icons/bridges.svg",
      "description":
          "Lorem ipsum dolor sit amet. Vel suscipit accusa ntium est rerum ipsa eos laudantium adipisci est neque i",
      "type": "Bridges Palcement",
      "color": AppColors.blue
    },
    {
      "name": "Ismail Alshoufi",
      "icon": "assets/icons/crowns.svg",
      "description":
          "Lorem ipsum dolor sit amet. Vel suscipit accusa ntium est rerum ipsa eos laudantium adipisci est neque i",
      "type": "Crowns Palcement",
      "color": AppColors.red
    },
    {
      "name": "Omran Almatni",
      "icon": "assets/icons/fillings.svg",
      "description":
          "Lorem ipsum dolor sit amet. Vel suscipit accus antium est rerum ",
      "type": "Fillings",
      "color": AppColors.darkBlue,
    },
    {
      "name": "Hakam Alsaadi",
      "icon": "assets/icons/root_canal.svg",
      "description":
          "Lorem ipsum dolor sit amet. Vel suscipit accus antium est rerum ipsa eos laudantium ",
      "type": "Root Canals",
      "color": AppColors.red,
    },
    {
      "name": "Omar Alaawar",
      "icon": "assets/icons/polish.svg",
      "description":
          "Lorem ipsum dolor sit adipisci est neque i amet. Vel suscipit accus antium est rerum ipsa eos laudantium adipisci est neque i",
      "type": "Polish & Cleaning",
      "color": AppColors.lightBlue
    },
    {
      "name": "Ammar Amer",
      "icon": "assets/icons/removal.svg",
      "description": "Loremeos laudantium adipisci est neque i",
      "type": "Tooth Removal",
      "color": AppColors.lightDarkBlue,
    },
    {
      "name": "Ashraf Sopeh",
      "icon": "assets/icons/implants.svg",
      "description":
          "Lorem ipsum dolor sit amet. Vel suscipit accus antium est rerum ipsa eos laudantium adipisci est neque i",
      "type": "Dental Implants",
      "color": AppColors.red,
    },
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            welcomeWidget(),
            const Empty().withHeight(15.h),
            _searchField().animate().fadeIn(duration: 400.milliseconds),
            const Empty().withHeight(20.h),
            _categories()
                .animate(delay: 400.milliseconds)
                .fadeIn(duration: 400.milliseconds),
            const Empty().withHeight(20.h),
            _recentVisitsWidget()
                .animate(delay: 700.milliseconds)
                .fadeIn(duration: 400.milliseconds),
          ],
        ).paddingAll(10),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0.0,
      leading: const Icon(Icons.menu_rounded, color: AppColors.darkBlue),
     
    );
  }

  Widget welcomeWidget(){
    return Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBlue.withOpacity(0.7),
                    ),
                  ),
                  Text(
                    "Dr. Omran",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBlue,
                    ),
                  ),
                ],
              ),
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: AppColors.silver,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 5),
                        color: AppColors.black.withOpacity(0.2),
                        blurRadius: 5,
                      )
                    ]),
                child: SvgPicture.asset('assets/icons/profile.svg').paddingAll(15),
                
              ),
            ],
          ).paddingSymmetric(horizontal: 5),
        );
  }

  Widget _searchField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 40.h,
          width: 280.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.silver,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 5,
                )
              ]),
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Search...',
              // alignLabelWithHint: true,
              prefixIcon:
                  Icon(Icons.search, color: AppColors.black.withOpacity(0.5)),
              contentPadding: const EdgeInsets.all(15),
              hintStyle: TextStyle(
                color: AppColors.black.withOpacity(0.37),
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
        Container(
          height: 40.h,
          width: 45.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.blue,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 10,
                )
              ]),
          child: Center(
            child: SvgPicture.asset('assets/icons/filter.svg'),
          ),
        )
      ],
    );
  }

  Widget _categories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        categoriesData.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.silver,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: AppColors.black.withOpacity(0.2),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Center(
                child: SvgPicture.asset(categoriesData[index]["icon"]),
              ),
            ),
            const Empty().withHeight(10),
            Text(
              categoriesData[index]["name"],
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentVisitsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recently",
          style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.darkBlue,
              fontWeight: FontWeight.w600),
        ),
        const Empty().withHeight(10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              visits.length,
              (index) => VisitCard(
                data : visits[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
