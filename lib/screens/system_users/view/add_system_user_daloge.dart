import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/screens/system_users/model/UserType.dart';
import 'package:qr_attend/screens/system_users/viewmodel/system_users_dialog_view_model.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/utils/colors.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:qr_attend/widgets/styled_text_field.dart';

import '../../../locator.dart';
import '../../base_screen.dart';

class SystemUserDialog extends StatelessWidget {
  SystemUserDialog();

  @override
  Widget build(BuildContext context) {
    return BaseScreen<SystemUsersDialogViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, _) {
        return SingleChildScrollView(
          child: SizedBox(
            width: 400,
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
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          locator<NavigationService>().goBack();
                        },
                      ),
                      bold14Text(tr('add_new_system_user')),
                    ],
                  ),
                  heightSpace(8),
                  const Divider(color: Colors.grey),
                  heightSpace(4),
                  StyledTextField(
                    controller: viewModel.idController,
                    hint: tr('id'),
                    validator: requiredValidator(),
                  ),
                  heightSpace(4),
                  StyledTextField(
                    controller: viewModel.nameController,
                    hint: tr('name'),
                    validator: requiredValidator(),
                  ),
                  heightSpace(8),
                  StyledTextField(
                    controller: viewModel.emailController,
                    hint: tr('email'),
                    validator: requiredValidator(),
                  ),
                  heightSpace(8),
                  StyledTextField(
                    controller: viewModel.passwordController,
                    hint: tr('password'),
                    validator: requiredValidator(),
                  ),
                  heightSpace(8),
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
                    child: DropdownButton<UserType>(
                      underline: const SizedBox(),
                      icon: const Visibility(
                          visible: false, child: Icon(Icons.arrow_downward)),
                      value: viewModel.selectedUserType,
                      items: viewModel.listUserTypeMethod.map((UserType value) {
                        return DropdownMenuItem<UserType>(
                          value: value,
                          child: Text(
                            value.getTranslatedName(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        viewModel.setUserType(value);
                      },
                    ),
                  ),
                  heightSpace(8),
                  heightSpace(16),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        viewModel.state == ViewState.Busy
                            ? const CircularProgressIndicator()
                            : TextButton(
                                onPressed: () async {
                                  viewModel.createNewSystemUser(context);
                                },
                                child: Text(
                                  tr('create'),
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                        const VerticalDivider(),
                        TextButton(
                          onPressed: () {
                            locator<NavigationService>().goBack();
                          },
                          child: Text(
                            tr('cancel'),
                            style: TextStyle(
                                color: greyColor,
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
          ),
        );
      },
    );
  }

  Padding permissionWidget(String role, SystemUsersDialogViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          bold14Text(tr(role)),
          Spacer(),
          Checkbox(
            value: viewModel.selectedRules.contains(role),
            onChanged: (value) {
              viewModel.setRule(role, value!);
            },
          )
        ],
      ),
    );
  }
}
