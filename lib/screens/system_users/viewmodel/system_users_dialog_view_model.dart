import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/login/model/system_user_model.dart';
import 'package:qr_attend/services/firebase_services.dart';
import 'package:qr_attend/utils/texts.dart';

import '../../../locator.dart';

class SystemUsersDialogViewModel extends BaseViewModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final _firebaseServices = locator<FirebaseServices>();

  List<SystemUserModel> systemUsers = [];
  List<String> selectedRules = [];

  void setRule(String role, bool selected) {
    try {
      if (selected) {
        selectedRules.add(role);
      } else {
        selectedRules.remove(role);
      }
    } catch (e) {}
    setState(ViewState.Idle);
  }

  void createNewSystemUser(context) async {
    setState(ViewState.Busy);
    Resource<SystemUserModel> response =
        await _firebaseServices.createNewSystemUser(
      nameController.value.text,
      emailController.value.text,
      passwordController.value.text,
    );
    switch (response.status) {
      case Status.SUCCESS:
        systemUsers.add(response.data!);
        await _firebaseServices.reLogin();
        Navigator.pop(context, response.data);
        break;
      case Status.ERROR:
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(tr(response.errorMessage!)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, // passing true
                  child: normal14Text(tr('ok_return')),
                ),
              ],
            );
          },
        );
        break;
      default:
        print('wtf');
    }
    setState(ViewState.Idle);
  }
}
