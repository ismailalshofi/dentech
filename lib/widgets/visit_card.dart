import 'package:dentech/core/utils/extensions/context_extensions.dart';
import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:dentech/core/values/values.dart';
import 'package:dentech/widgets/visit_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisitCard extends StatefulWidget {
  final data;

  const VisitCard({
    super.key,
    required this.data,
  });

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> with TickerProviderStateMixin {
  AnimationController? controller;

  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller!.duration = const Duration(milliseconds: 800);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: widget.data['color'],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['name'],
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Divider(
                    color: AppColors.white,
                    thickness: 1.5,
                  ).withWidth(100.w),
                  Text(
                    widget.data['description'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ).withWidth(150.w),
                ],
              ),
              Text(
                widget.data['type'],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ).withWidth(150.w),
            ],
          ).paddingAll(8),
          Container(
            width: 150.w,
            height: 150.h,
            decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(80),
                  bottomLeft: Radius.circular(50),
                )),
            child: SvgPicture.asset(widget.data['icon'], width: 100.w).paddingAll(25),
          )
        ],
      ),
    ).paddingAll(3).onTap(() => showVisitInfo(context));
  }

  showVisitInfo(BuildContext context) {
    showModalBottomSheet(
      transitionAnimationController: controller!,
      context: context,
      isScrollControlled: true,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      barrierColor: AppColors.black.withOpacity(0.5),
      elevation: 1.5,
      constraints: BoxConstraints(maxHeight: 600.h),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      )),
      builder: (context) => VisitInfo(data : widget.data),
    );
  }
}
