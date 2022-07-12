import 'package:flutter/material.dart';
import 'package:qr_attend/screens/attends/viewmodel/select_attend_type_view_model.dart';
import 'package:qr_attend/screens/subjects/model/category_model.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_view_model.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/widgets/center_progress.dart';

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
        return Center(
          child: Container(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<SubjectModel>(
                    underline: const SizedBox(),
                    icon: const Visibility(
                        visible: false, child: Icon(Icons.arrow_downward)),
                    value: viewModel.selectedSubjectModel,
                    items: currentAllSubjects.map((SubjectModel value) {
                      return DropdownMenuItem<SubjectModel>(
                        value: value,
                        child: Text(value.name!,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      viewModel.setSelctedSubject(value);
                    },
                  ),
                ),
                heightSpace(16),

              ],
            ),
          ),
        );
      },
    );
  }
}
