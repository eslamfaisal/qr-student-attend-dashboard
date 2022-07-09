import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/screens/login/model/system_user_model.dart';
import 'package:qr_attend/screens/system_users/viewmodel/system_users_view_model.dart';
import 'package:qr_attend/screens/system_users/widget/system_user_widget.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:qr_attend/widgets/center_progress.dart';

import '../../base_screen.dart';
import 'add_system_user_daloge.dart';

class SystemUsersScreen extends StatelessWidget {
  const SystemUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen<SystemUsersViewModel>(
      onModelReady: (viewModel) {
        viewModel.getSystemUsers();
      },
      builder: (context, viewModel, _) {
        if (viewModel.state == ViewState.Busy)
          return CenterProgress();
        else {
          return SafeArea(
            child: Scaffold(
                body: Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, top: 16, right: 8, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr('system_users'),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Row(
                            children: [
                              bold14Text(tr('add_new_system_user')),
                              widthSpace(4),
                              Icon(
                                Icons.add_box_outlined,
                                size: 40,
                              ),
                            ],
                          ).onTap(
                            () async {
                              SystemUserModel? user = await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  content: SystemUserDialog(),
                                ),
                              );

                              if(user!=null)
                              viewModel.insert(0, user);
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
                              bold14Text(tr('name')),
                              VerticalDivider(),
                              bold14Text(tr('email')),
                              VerticalDivider(),
                              bold14Text(tr('action')),
                            ],
                          ),
                          Divider(),
                          viewModel.systemUsers.length == 0
                              ? Container()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: viewModel.systemUsers.length,
                                  itemBuilder: (context, index) {
                                    return SystemUserWidget(
                                      viewModel: viewModel,
                                      index: index,
                                    );
                                  },
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          );
        }
      },
    );
  }
}
