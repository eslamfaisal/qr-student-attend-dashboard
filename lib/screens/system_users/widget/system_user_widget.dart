import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/screens/login/model/system_user_model.dart';
import 'package:qr_attend/screens/system_users/viewmodel/system_users_view_model.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';

class SystemUserWidget extends StatelessWidget {
  final SystemUsersViewModel viewModel;
  final int index;

  const SystemUserWidget(
      {Key? key, required this.viewModel, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemUserModel model = viewModel.systemUsers[index];

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
                    notNullString(model.name),
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Center(
                  child: bold14Text(
                    notNullString(model.email),
                  ),
                ),
              ),
              VerticalDivider(),
              Expanded(
                flex: 1,
                child: Icon(
                        Icons.delete,
                        color: primaryColor,
                      ).onTap(() async {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: normal14Text('delete_user_msg'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  viewModel.deleteUser(index);
                                  Navigator.pop(context);
                                },
                                child: normal14Text(tr('yes'),
                                    color: Colors.white),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: normal14Text(tr('cancel'),
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
