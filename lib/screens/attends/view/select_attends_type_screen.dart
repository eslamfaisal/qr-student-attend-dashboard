import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_attend/screens/attends/model/attend_date_model.dart';
import 'package:qr_attend/screens/attends/model/attends_type.dart';
import 'package:qr_attend/screens/attends/viewmodel/select_attend_type_view_model.dart';
import 'package:qr_attend/screens/login/model/system_user_model.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
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
                  Divider(
                    color: blackColor,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 50,
                      ),
                      VerticalDivider(
                        color: blackColor,
                      ),
                      ...viewModel.subjectAttendsDateList.map((date) {
                        return Row(
                          children: [
                            IntrinsicHeight(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  alignment: Alignment.center,
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
                            ))
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                  Divider(
                    color: blackColor,
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
                              ...viewModel.allStudentUsersList.map((user) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: 200,
                                            height: 60,
                                            child: Text(
                                              user.name!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          getUserAttendPercentage(
                                              viewModel, user),
                                          ...getStudendAttends(viewModel, user),
                                          // ...viewModel.allAttendsList.map((attend) =>
                                          //     AttendCheckBox(
                                          //         viewModel, user, attend)),
                                          VerticalDivider(
                                            color: blackColor,
                                          ),
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

  Iterable<Widget> getStudendAttends(
      SelectAttendTypeViewModel viewModel, SystemUserModel user) {
    List<Widget> widgets = [];
    int index = 0;
    viewModel.subjectAttendsDateList.forEach((date) {
      try {
        widgets.add(AttendCheckBox(viewModel, user, date));
      } catch (e) {
        print(e);
        widgets.add(AttendCheckBox(viewModel, user, null));
      }
      index++;
    });
    return widgets;
  }

  getUserAttendPercentage(
      SelectAttendTypeViewModel viewModel, SystemUserModel user) {
    int attendCount = 0;
    int totalCount = viewModel.subjectAttendsDateList.length;
    for (var date in viewModel.allAttendsList) {
      try {
        if (date.userId == user.id) {
          attendCount++;
        }
      } catch (e) {
        print(e);
      }
    }

    var percent = (attendCount / totalCount) * 100;
    return Container(
      width: 100,
      height: 50,
      child: Center(
        child: Row(
          children: [
            Text(
              '${percent.toStringAsFixed(2)}%',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            widthSpace(8),
            if(percent < 80)
            IconButton(
                onPressed: () {
                  sendWarning(user.id!, viewModel.selectedSubjectModel!.name!);
                },
                icon: const Icon(Icons.notification_important_outlined, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}

sendWarning(String id, String subject) async {
  var headers = {
    'Authorization':
        'key=AAAA6Sg2kp4:APA91bE-9osWFHmjWluvpjUukDkK7T05bfrMeCFxKBVTt1_bhNBjChEx4K69NU9xYhbvVBv_FXpBRXP9ceCrLCHFTy3PNOJafi_SmBkbWZvNqAKrIkWA7LrZBR8ZK3QQhEU3rPsNqSA8',
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var request =
      http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
  request.body = json.encode({
    "to": "/topics/${id}",
    "notification": {
      "body":
          "You have exceeded the limit of absence, and this is the first warning, and please attend ($subject) on the specified dates, Computer and Information Students Affairs",
      "OrganizationId": "2",
      "content_available": true,
      "priority": "high"
    }
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}

class AttendCheckBox extends StatefulWidget {
  final SelectAttendTypeViewModel viewModel;
  final SystemUserModel user;
  final AttendDateModel? attend;

  AttendCheckBox(this.viewModel, this.user, this.attend);

  @override
  State<AttendCheckBox> createState() => _AttendCheckBoxState();
}

class _AttendCheckBoxState extends State<AttendCheckBox> {
  var isSelected = false;

  @override
  void initState() {
    super.initState();
    if (widget.attend != null) {
      calculateSelection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        VerticalDivider(
          color: blackColor,
        ),
        Container(
          width: 150,
          child: Center(
            child: Checkbox(
              value: isSelected,
              onChanged: (_) {},
            ),
          ),
        ),
      ],
    );
  }

  void calculateSelection() {
    widget.viewModel.allAttendsList.forEach((attend) {
      if (attend.userId == widget.user.id &&
          attend.date == widget.attend!.date &&
          attend.attendType == widget.attend!.type) {
        isSelected = true;
      }
    });
    setState(() {});
  }
}
