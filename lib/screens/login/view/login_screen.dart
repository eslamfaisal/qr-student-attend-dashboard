import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/routs/routs_names.dart';
import 'package:qr_attend/screens/login/viewmodel/login_view_model.dart';
import 'package:qr_attend/services/firebase_services.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/utils/common_functions.dart';
import 'package:qr_attend/utils/extensions.dart';
import 'package:qr_attend/utils/texts.dart';
import 'package:qr_attend/widgets/StyledButton.dart';
import 'package:qr_attend/widgets/styled_text_field.dart';

import '../../../locator.dart';
import '../../base_screen.dart';

import 'dart:html' as html;
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScreen<LoginViewModel>(
      builder: (context, loginViewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                width: 400,
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Center(
                    child: Form(
                      key: loginViewModel.formKey,
                      child: Column(
                        children: [
                          // SizedBox(
                          //   width: 300,
                          //   height: 300,
                          //   child: Image.asset('assets/images/ic_logo.png'),
                          // ),
                          headerText(
                            tr('login'),
                          ),
                          heightSpace(16),
                          StyledTextField(
                            controller: loginViewModel.emailController,
                            hint: tr('email'),
                            validator: loginViewModel.emailValidator(),
                          ),
                          heightSpace(8),
                          StyledTextField(
                            controller: loginViewModel.passwordController,
                            hint: tr('password'),
                            validator: loginViewModel.passwordValidator(),
                            isPassword: true,
                          ),
                          heightSpace(24),
                          loginViewModel.state == ViewState.Busy
                              ? const Center(child: CircularProgressIndicator())
                              : StyledButton(tr("login")).onTap(() async {
                                  Resource<String> response =
                                      await loginViewModel.login();

                                  if (response.status == Status.ERROR) {
                                    final snackBar = SnackBar(
                                        content:
                                            Text(tr(response.errorMessage!)));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    html.window.location.reload();
                                  }
                                }),
                          heightSpace(16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
