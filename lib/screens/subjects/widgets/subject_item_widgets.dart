import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/locator.dart';
import 'package:qr_attend/routs/routs_names.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
import 'package:qr_attend/screens/subjects/view/subject_dialog_widget.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_view_model.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';

class SubjectItemWidget extends StatelessWidget {
  final int index;
  final SubjectsViewModel viewModel;

  SubjectItemWidget(this.index, this.viewModel);

  @override
  Widget build(BuildContext context) {
    SubjectModel category = currentAllSubjects[index];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    notNullString(category.name),
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    tr('lectures'),
                  ),
                ).onTap(() {
                  locator<NavigationService>().navigateTo(
                    RouteName.SUBJECT_ATTENDS_SCREEN,
                    queryParams: {
                      'type': 'Lecture',
                    },
                    arguments: category,
                  );
                }),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    tr('sections'),
                  ),
                ).onTap(() {
                  locator<NavigationService>().navigateTo(
                    RouteName.SUBJECT_ATTENDS_SCREEN,
                    queryParams: {
                      'type': 'Section',
                    },
                    arguments: category,
                  );
                }),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: primaryColor,
                    ).onTap(() async {
                      await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: SubjectDialogWidget(
                            isNewCategory: false,
                            categoryModel: currentAllSubjects[index],
                          ),
                        ),
                      );
                    }),
                    widthSpace(8),
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
          Divider(),
        ],
      ),
    );
  }
}
