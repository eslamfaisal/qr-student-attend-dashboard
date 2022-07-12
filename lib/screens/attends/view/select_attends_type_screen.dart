import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/screens/attends/model/attends_type.dart';
import 'package:qr_attend/screens/attends/viewmodel/select_attend_type_view_model.dart';
import 'package:qr_attend/screens/subjects/model/category_model.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_view_model.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';

import '../../base_screen.dart';

class SelectAttendsTypeScreen extends StatelessWidget {
  const SelectAttendsTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<SelectAttendTypeViewModel>(
      onModelReady: (viewModel) {
        viewModel.initSelection();
      },
      builder: (context, viewModel, _) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, right: 8, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr("attends"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  heightSpace(16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<SubjectModel>(
                            underline: const SizedBox(),
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            value: viewModel.selectedSubjectModel,
                            items: currentAllSubjects.map((SubjectModel value) {
                              return DropdownMenuItem<SubjectModel>(
                                value: value,
                                child: Text(
                                  value.name!,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              viewModel.setSelectedSubject(value);
                            },
                          ),
                        ),
                      ),
                      widthSpace(16),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<AttendType>(
                            underline: const SizedBox(),
                            icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward)),
                            value: viewModel.selectedAttendType,
                            items:
                                viewModel.attendTypes.map((AttendType value) {
                              return DropdownMenuItem<AttendType>(
                                value: value,
                                child: Text(
                                  value.name,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              viewModel.setSelectedAttend(value);
                            },
                          ),
                        ),
                      ),
                      widthSpace(16),
                      if (viewModel.selectedAttendType == AttendType.Section)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<int>(
                              underline: const SizedBox(),
                              icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward)),
                              value: viewModel.selectedSectionNumber,
                              items: viewModel.sectionsNumbers.map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                viewModel.setSelectedSectionNumber(value);
                              },
                            ),
                          ),
                        ),
                      widthSpace(16),
                    ],
                  ),
                  heightSpace(16),
                  if (viewModel.subjectAttendsDateList.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 200,
                                  ),
                                  ...viewModel.subjectAttendsDateList
                                      .map((date) {
                                    return Container(
                                      width: 150,
                                      alignment: Alignment.center,
                                      child: IntrinsicHeight(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                date.date!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          const VerticalDivider(
                                            color: Colors.black,
                                          ),
                                        ],
                                      )),
                                    );
                                  }).toList(),
                                ],
                              ),
                              Divider(
                                color: blackColor,
                              ),
                              ...viewModel.allStudentUsersList.map((date) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 180,
                                            height: 60,
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                date.name!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          ...viewModel.allAttendsList
                                              .map((e) => Row(
                                                    children: [
                                                      VerticalDivider(
                                                        color: blackColor,
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        child: Center(
                                                          child: Checkbox(
                                                            value: true,
                                                            onChanged: (_) {},
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: blackColor,
                                    )
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
