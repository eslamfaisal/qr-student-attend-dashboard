import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_view_model.dart';
import 'package:qr_attend/screens/subjects/widgets/subject_item_widgets.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:qr_attend/widgets/center_progress.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../base_screen.dart';
import 'subject_dialog_widget.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<SubjectsViewModel>(
      onModelReady: (viewModel) {
        viewModel.getSubjects();
      },
      builder: (context, viewModel, _) {
        if (viewModel.state == ViewState.Busy) {
          return const CenterProgress();
        } else {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
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
                              tr("subjects"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Row(
                              children: [
                                bold14Text(tr('add_new_subject')),
                                widthSpace(4),
                                const Icon(
                                  Icons.add_box_outlined,
                                  size: 40,
                                ),
                              ],
                            ).onTap(
                              () async {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    content: SubjectDialogWidget(
                                        isNewCategory: true),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      heightSpace(16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: semiDarkGrey),
                        ),
                        child: Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                bold14Text(tr('title')),
                                VerticalDivider(),
                                bold14Text(tr('تواريخ المحاضرات')),
                                VerticalDivider(),
                                bold14Text(tr('تواريخ السكاشن')),
                                VerticalDivider(),
                                bold14Text(tr('action')),
                              ],
                            ),
                            Divider(),
                            currentAllSubjects == null
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: currentAllSubjects.length,
                                    itemBuilder: (context, index) {
                                      return SubjectItemWidget(
                                          index, viewModel);
                                    },
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
