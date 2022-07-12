import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
import 'package:qr_attend/screens/subjects/view/subject_date_dialog_widget.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_dates_view_model.dart';
import 'package:qr_attend/screens/subjects/viewmodel/subjects_view_model.dart';
import 'package:qr_attend/screens/subjects/widgets/subject_date_item_widgets.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:qr_attend/widgets/center_progress.dart';

import '../../base_screen.dart';

class SubjectsDatesScreen extends StatelessWidget {
  final String type;
  final SubjectModel subjectModel;

  SubjectsDatesScreen(this.subjectModel, this.type, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<SubjectsDatesViewModel>(
      onModelReady: (viewModel) {
        viewModel.getSubjectsDates(subjectModel, type);
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
                              tr("attends"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            Row(
                              children: [
                                bold14Text(tr('add')),
                                widthSpace(4),
                                const Icon(
                                  Icons.add_box_outlined,
                                  size: 40,
                                ),
                              ],
                            ).onTap(
                              () async {
                                var attend = await showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    content: SubjectDateDialogWidget(
                                      attendType: type,
                                      subjectID: subjectModel.id,
                                    ),
                                  ),
                                );

                                if (attend != null) {
                                  viewModel.addNewAttendDate(attend);
                                }
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
                                bold14Text(tr(type)),
                                VerticalDivider(),
                                if (type == 'Section') bold14Text(tr('رقم السكشن')),
                                if (type == 'Section') VerticalDivider(),
                                bold14Text(tr('action')),
                              ],
                            ),
                            Divider(),
                            currentAllSubjects == null
                                ? Container()
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: viewModel.attendsDates.length,
                                    itemBuilder: (context, index) {
                                      return SubjectDateItemWidget(
                                        type,
                                        index,
                                        viewModel,
                                      );
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
