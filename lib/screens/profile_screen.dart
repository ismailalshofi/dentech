import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:dentech/core/values/values.dart';
import 'package:dentech/core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfileScreen extends StatelessWidget {
  List<WorkingData> data = [
    WorkingData(DateTime(2023, 8, 21), 6),
    WorkingData(DateTime(2023, 8, 22), 4),
    WorkingData(DateTime(2023, 8, 23), 8),
    WorkingData(DateTime(2023, 8, 24), 2),
    WorkingData(DateTime(2023, 8, 25), 3),
    WorkingData(DateTime(2023, 8, 26), 8),
    WorkingData(DateTime(2023, 8, 27), 5),
  ];
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 250.h,
            backgroundColor: AppColors.silver,
            flexibleSpace: FlexibleSpaceBar(
              background: _profileHeader(),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              child: _profileBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/images/omran.png',
        ),
        Container(
          width: 160.w,
          height: 150.h,
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(25.sp),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your time spent providing care",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Divider(thickness: 2, color: AppColors.white, endIndent: 10.w),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "136",
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 25.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: " days",
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 13.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "4 months & 16 days",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ).paddingAll(8.sp),
        ),
      ],
    );
  }

  Widget _profileBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        progresGraph(),
        overallStatistic(),
      ],
    ).paddingAll(10.sp);
  }

  Widget progresGraph() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Progress Graph",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.darkBlue,
                  fontWeight: FontWeight.w600),
            ),
            Divider(color: AppColors.darkBlue, thickness: 1.5, endIndent: 10.w),
            Text(
              "This graph shows the number of patients treated over the days of the previous week",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Show specific week or month progress",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
            Container(
              height: 30.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.blue,
              ),
              child: const Center(
                child: Icon(Icons.keyboard_arrow_down, color: AppColors.white),
              ),
            )
          ],
        ),
        30.height,
        _buildDefaultDateTimeAxisChart(),
      ],
    );
  }

  Widget overallStatistic() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall Statistics",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(color: AppColors.darkBlue, thickness: 1.5, endIndent: 10.w),
          ],
        ),
        10.height,
        dataCard(
            Image.asset('assets/icons/visit.png'), 'Patients Treated', '216'),
        dataCard(circularDot(), 'Bridges Treatment', '13'),
        dataCard(circularDot(), 'Fillings Treatment', '25'),
        dataCard(circularDot(), 'Crowns Treatment', '22'),
        dataCard(circularDot(), 'Implants Treatment', '7'),
        dataCard(circularDot(), 'Removal Treatment', '13'),
        dataCard(circularDot(), 'Polish Treatment', '35'),
        dataCard(circularDot(), 'Root Canal Treatment', '17'),
      ],
    );
  }

  Widget circularDot() {
    return Container(
      height: 8.h,
      width: 8.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.black.withOpacity(0.6),
      ),
      child: const Empty(),
    );
  }

  SfCartesianChart _buildDefaultDateTimeAxisChart() {
    return SfCartesianChart(
      enableAxisAnimation: true,
      zoomPanBehavior: ZoomPanBehavior(
        enablePinching: true,
        enableMouseWheelZooming: true,
        enablePanning: true,
        enableSelectionZooming: true,
      ),
      primaryXAxis: DateTimeCategoryAxis(
        majorGridLines: const MajorGridLines(width: 1),
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryYAxis: NumericAxis(
          maximum: 8,
          majorTickLines: const MajorTickLines(size: 10),
          axisLine: const AxisLine(width: 0),
          anchorRangeToVisiblePoints: true),
      series: <ColumnSeries<WorkingData, DateTime>>[
        ColumnSeries<WorkingData, DateTime>(
          dataSource: data,
          xValueMapper: (WorkingData x, int xx) => x.day,
          yValueMapper: (WorkingData day, _) => day.patients,
          color: AppColors.blue,
          width: 0.2,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.sp),
            topRight: Radius.circular(15.sp),
          ),
        ),
      ],
      onTooltipRender: (TooltipArgs args) {
        args.header = 'Treated Patients';
        args.text =
            '${args.dataPoints![args.pointIndex!.toInt()].x.day} : ${args.dataPoints![args.pointIndex!.toInt()].y} Patients';
      },
    );
  }

  Widget dataCard(Widget img, String title, String text) {
    return Container(
      width: 330.w,
      height: 45.h,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.silver,
          borderRadius: BorderRadius.circular(25),
          border:
              Border.all(color: AppColors.darkBlue.withOpacity(0.5), width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              img.paddingAll(8.sp),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, color: AppColors.black.withOpacity(0.6))
              .withHeight(25.h),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ).paddingSymmetric(vertical: 5);
  }
}

class WorkingData {
  final DateTime day;
  final int patients;

  WorkingData(this.day, this.patients);
}
