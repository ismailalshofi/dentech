import 'package:dentech/core/utils/extensions/context_extensions.dart';
import 'package:dentech/core/utils/extensions/int_extensions.dart';
import 'package:dentech/core/utils/extensions/widget_extensions.dart';
import 'package:dentech/core/values/values.dart';
import 'package:dentech/core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddVisitScreen extends StatefulWidget {
  const AddVisitScreen({super.key});

  @override
  State<AddVisitScreen> createState() => _AddVisitScreenState();
}

class _AddVisitScreenState extends State<AddVisitScreen> {
  List<String> patients = ["Ismail", "Sarkis", "Omran", "Ammar"];
  List<String> treatments = [
    "Tooth Removal",
    "Root Canals",
    "Polish & Cleaning",
    "Tooth Implants",
    "Crowns Placement",
    "Bridges Placement",
    "Fillings"
  ];

  List<String> locations = ['Jaramana', 'Salkhad', 'Alswaida'];
  String selectedLocation = "";
  String selectedTreatment = "";
  DateTime selecteDate = DateTime.now();
  final selectedPatient = TextEditingController();
  final description = TextEditingController();

  // jaw and teeth

  int? selectedTeeth;
  int? selectedJaw;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Visit",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(color: AppColors.darkBlue, thickness: 1.5, endIndent: 10.w),
            10.height,
            _selectPatient(),
            15.height,
            _dateAndLocation(),
            15.height,
            _treatmentType(),
            15.height,
            _treatedTeeth(),
            15.height,
            _description(),
            15.height,
            _images(),
          ],
        ).paddingAll(10.sp),
      ),
    );
  }

  Widget _selectPatient() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40.h,
          width: 250.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: AppColors.silver,
            border:
                Border.all(color: AppColors.black.withOpacity(0.5), width: 1),
          ),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: selectedPatient,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Select Patient',
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
            suggestionsCallback: (pattern) {
              return patients.where((element) =>
                  element.toLowerCase().startsWith(pattern.toLowerCase()));
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                leading: const Icon(Icons.person_2_rounded),
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (suggestion) {
              setState(() {
                selectedPatient.text = suggestion;
              });
            },
          ),
        ),
        Container(
          height: 40.h,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: AppColors.blue,
          ),
          child: Center(
            child: Text(
              "Add New",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 10.sp,
              ),
            ),
          ).paddingAll(5),
        )
      ],
    );
  }

  Widget _dateAndLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
            10.height,
            Container(
                height: 40.h,
                width: 180.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: AppColors.silver,
                  border: Border.all(
                      color: AppColors.black.withOpacity(0.5), width: 0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.location_city,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text(
                          'Select Location',
                          style: TextStyle(
                            color: AppColors.black.withOpacity(0.37),
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        value: selectedLocation.isNotEmpty
                            ? selectedLocation
                            : null,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                        underline: const Empty(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedLocation = value!;
                          });
                        },
                        items: locations
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date",
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.darkBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
            10.height,
            Container(
                height: 40.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: AppColors.silver,
                  border: Border.all(
                      color: AppColors.black.withOpacity(0.5), width: 0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.date_range,
                    ),
                    Text(selecteDate.toString().substring(0, 10))
                  ],
                )),
          ],
        )
      ],
    );
  }

  Widget _treatmentType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Treatement Type",
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
        10.height,
        Container(
            height: 40.h,
            width: 320.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: AppColors.silver,
              border: Border.all(
                  color: AppColors.black.withOpacity(0.5), width: 0.8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.local_hospital,
                ),
                const Empty(),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      'Treatement Type',
                      style: TextStyle(
                        color: AppColors.black.withOpacity(0.37),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                    value:
                        selectedTreatment.isNotEmpty ? selectedTreatment : null,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                    underline: const Empty(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedTreatment = value!;
                      });
                    },
                    items: treatments
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget _treatedTeeth() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Treated Teeth",
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
        10.height,
        Container(
          width: 330.w,
          // height: 45.h,
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.silver,
            borderRadius: BorderRadius.circular(20.sp),
            border:
                Border.all(color: AppColors.black.withOpacity(0.5), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _jawWidget(),
              VerticalDivider(
                      thickness: 1, color: AppColors.black.withOpacity(0.6))
                  .withHeight(120.h),
              _teethNumbers(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _jawWidget() {
    return Column(
      children: [
        25.height,
        Row(
          children: [
            Transform.flip(
              flipX: true,
              child: Image.asset(
                'assets/icons/jaw.png',
                color: selectedJaw == 0
                    ? AppColors.blue
                    : AppColors.black.withOpacity(0.6),
                height: 60.h,
              ),
            ).onTap(() => setState(() => selectedJaw = 0)),
            20.width,
            Transform.flip(
              flipX: false,
              child: Image.asset(
                'assets/icons/jaw.png',
                color: selectedJaw == 1
                    ? AppColors.blue
                    : AppColors.black.withOpacity(0.6),
                height: 60.h,
              ),
            ).onTap(() => setState(() => selectedJaw = 1)),
          ],
        ),
        Divider(thickness: 1.5, color: AppColors.black.withOpacity(0.6))
            .withWidth(80.w),
        Row(
          children: [
            Transform.flip(
              flipX: true,
              flipY: true,
              child: Image.asset(
                'assets/icons/jaw.png',
                color: selectedJaw == 2
                    ? AppColors.blue
                    : AppColors.black.withOpacity(0.6),
                height: 60.h,
              ),
            ).onTap(() => setState(() => selectedJaw = 2)),
            20.width,
            Transform.flip(
              flipX: false,
              flipY: true,
              child: Image.asset(
                'assets/icons/jaw.png',
                color: selectedJaw == 3
                    ? AppColors.blue
                    : AppColors.black.withOpacity(0.6),
                height: 60.h,
              ),
            ).onTap(() => setState(() => selectedJaw = 3)),
          ],
        ),
        25.height,
      ],
    );
  }

  Widget _teethNumbers() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color:
                    selectedTeeth == index ? AppColors.blue : AppColors.silver,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.black.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Text(
                (index + 1).toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: selectedTeeth == index
                      ? AppColors.white
                      : AppColors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ).paddingSymmetric(vertical: 10, horizontal: 20),
            ).onTap(() => setState(() => selectedTeeth = index)),
          ),
        ),
        20.height,
        Row(
          children: List.generate(
            3,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: selectedTeeth == index + 3
                    ? AppColors.blue
                    : AppColors.silver,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.black.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Text(
                (index + 4).toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: selectedTeeth == index + 3
                      ? AppColors.white
                      : AppColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ).paddingSymmetric(vertical: 10, horizontal: 20),
            ).onTap(() => setState(() => selectedTeeth = index + 3)),
          ),
        ),
      ],
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
        10.height,
        Container(
          // height: 150.h,
          width: 320.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.silver,
             border: Border.all(color: AppColors.black.withOpacity(0.5), width: 1),
          ),
          child: TextFormField(
            maxLines: 8,
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'type something or hold the mice',
              suffixIcon: IconButton(onPressed: (){} , icon: Icon(Icons.mic_external_on),),
              contentPadding: const EdgeInsets.all(15),
              hintStyle: TextStyle(
                color: AppColors.black.withOpacity(0.37),
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _images(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attachments",
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.darkBlue,
            fontWeight: FontWeight.w400,
          ),
        ),
        10.height,
        Container(
            height: 40.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: AppColors.silver,
                border:Border.all(color: AppColors.black.withOpacity(0.5), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Upload", style: TextStyle(color: AppColors.black.withOpacity(0.6)),),
                  Icon(Icons.upload, color: AppColors.black.withOpacity(0.6)),
                ],
              ),
        ),
      ],
    );
  }
}
