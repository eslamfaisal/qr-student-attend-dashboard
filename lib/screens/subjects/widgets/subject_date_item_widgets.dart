import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/screens/attends/model/attend_date_model.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_dates_view_model.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';

class SubjectDateItemWidget extends StatelessWidget {
  final String type;
  final int index;
  final SubjectsDatesViewModel viewModel;

  SubjectDateItemWidget(this.type, this.index, this.viewModel);

  @override
  Widget build(BuildContext context) {
    AttendDateModel category = viewModel.attendsDates[index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    notNullString(category.date),
                  ),
                ),
              ),
              const VerticalDivider(),
              if(type == 'Section')
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    notNullString(category.sectionNumber),
                  ),
                ),
              ),
              if(type == 'Section')
              const VerticalDivider(),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: primaryColor,
                    ).onTap(
                      () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text(tr('delete_category_msg')),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: bold14Text(tr('cancel'),
                                      color: primaryColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    viewModel.delete(index);
                                    final snackBar = SnackBar(
                                        content:
                                            Text(tr('deleted_successfully')));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    Navigator.pop(context, false);
                                  }, // passing true
                                  child: normal14Text(tr('delete')),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
