import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/utils/sizer.dart';
import '../core/values/values.dart';

class VisitInfo extends StatelessWidget {
  final data;

  const VisitInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
                title: Text(
                  data['name'],
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Male',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      data['type'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )).withWidth(Sizer.screenWidth / 2),
            Container(
              height: 100.h,
              width: 130.w,
              decoration: BoxDecoration(
                color: data['color'],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(80),
                ),
              ),
              child: SvgPicture.asset(data['icon']).paddingAll(20),
            )
          ],
        ),
        const Divider(
          color: AppColors.darkBlue,
          thickness: 0.6,
        ).withWidth(320.w),
        Text(
          data['description'] + data['description'],
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w300,
          ),
        ).paddingAll(10.w),
        30.height,
        dataCard('assets/icons/teeth.png', 'lorem ipsum'),
        dataCard('assets/icons/visit.png', '4 Visits'),
        dataCard('assets/icons/dates.png', '2 Months'),
        dataCard('assets/icons/location.png', 'Jaramana'),
      ],
    );
  }

  Widget dataCard(String img, String text) {
    return Container(
      width: 330.w,
      height: 45.h,
      decoration: BoxDecoration(
          color: AppColors.silver,
          borderRadius: BorderRadius.circular(25),
          border:
              Border.all(color: AppColors.darkBlue.withOpacity(0.5), width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(img).withWidth(100.w),
          VerticalDivider(thickness: 1, color: AppColors.black.withOpacity(0.6)).withHeight(25.h),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ).withWidth(100.w),
        ],
      ),
    ).paddingSymmetric(vertical: 5);
  }
}
