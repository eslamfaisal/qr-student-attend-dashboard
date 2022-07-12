import 'dart:convert';

import 'package:qr_attend/routs/routs_names.dart';
import 'package:qr_attend/screens/system_users/viewmodel/system_users_view_model.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:qr_attend/utils/constants.dart';
import 'package:qr_attend/utils/shared_preferences_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../locator.dart';
import '../../base_view_model.dart';
import '../../login/model/system_user_model.dart';

class SplashViewModel extends BaseViewModel {
  void checkLogin() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = await Future.value(prefs.getBool(LOGGED_IN) ?? false);
      if (isLoggedIn) {
        String userJsonString =
            await Future.value(prefs.getString(USER_DETAILS));
        Map<String, dynamic> user = await jsonDecode(userJsonString);
        SystemUserModel userEvent = SystemUserModel.fromJson(user);
        currentLoggedInUserData = userEvent;

        getSystemdInitialData();
        locator<NavigationService>()
            .navigateToAndClearStack(RouteName.SUBJECTS_SCREEN);
      } else {
        locator<NavigationService>().navigateToAndClearStack(RouteName.LOGIN);
      }
    } catch (e) {
      locator<NavigationService>().navigateToAndClearStack(RouteName.LOGIN);
    }
  }

  void getSystemdInitialData() {
    locator<SystemUsersViewModel>().getSystemUsers();
  }
}
