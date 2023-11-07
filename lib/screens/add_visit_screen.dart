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
                )
                ),
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
                    value: selectedTreatment.isNotEmpty ? selectedTreatment : null,
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
                    items: treatments.map<DropdownMenuItem<String>>((String value) {
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
}
