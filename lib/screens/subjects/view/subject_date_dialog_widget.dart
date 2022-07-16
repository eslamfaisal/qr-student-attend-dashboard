import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/locator.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/attends/model/attend_date_model.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_date_dialog_view_model.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:qr_attend/widgets/styled_text_field.dart';

import '../../base_screen.dart';

class SubjectDateDialogWidget extends StatelessWidget {
  String? attendType = 'Section';
  String? subjectID = '';

  SubjectDateDialogWidget({this.attendType, this.subjectID});

  @override
  Widget build(BuildContext context) {
    return BaseScreen<CategoryDateDialogViewModel>(
      onModelReady: (viewModel) {
        viewModel.initSubjectAttendDate(attendType!, subjectID!);
      },
      builder: (c, viewModel, _) {
        return SingleChildScrollView(
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bold14Text(tr('اضافه')),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        locator<NavigationService>().goBack();
                      },
                    )
                  ],
                ),
                heightSpace(8),
                const Divider(color: Colors.grey),
                heightSpace(4),
                StyledTextField(
                  controller: viewModel.dateController,
                  hint: tr('التاريخ'),
                  validator: requiredValidator(),
                    enabled: false
                ).onTap((){
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(DateTime.now().year + 1),
                  ).then((date) {
                    if (date != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                      viewModel.dateController.text = formattedDate;
                    }
                  });
                }),
                heightSpace(4),
                if (attendType == 'Section')
                  StyledTextField(
                    controller: viewModel.sectionNumberController,
                    hint: tr('رقم السكشن'),
                    validator: requiredValidator(),
                  ),
                heightSpace(16),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      viewModel.state == ViewState.Busy
                          ? const CircularProgressIndicator()
                          : TextButton(
                              onPressed: () async {
                                Resource<AttendDateModel>? response =
                                    await viewModel.create();

                                if (response.status == Status.ERROR) {
                                  final snackBar = SnackBar(
                                      content: Text(response.errorMessage!));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  final snackBar = SnackBar(
                                      content:
                                          Text(tr('created_successfully')));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.pop(context, response.data);
                                }
                              },
                              child: Text(
                                tr('create'),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                      VerticalDivider(),
                      TextButton(
                        onPressed: () {
                          locator<NavigationService>().goBack();
                        },
                        child: Text(
                          tr('cancel'),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
