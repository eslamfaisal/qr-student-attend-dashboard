import 'dart:convert';

import 'package:qr_attend/routs/routs_names.dart';
import 'package:qr_attend/screens/categories/viewmodel/categories_view_model.dart';
import 'package:qr_attend/screens/countries/viewmodel/countries_view_model.dart';
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
        locator<NavigationService>()
            .navigateToAndClearStack(RouteName.COUPONS_OFFERS_SCREEN);
      } else {
        locator<NavigationService>().navigateToAndClearStack(RouteName.LOGIN);
      }
    } catch (e) {
      locator<NavigationService>().navigateToAndClearStack(RouteName.LOGIN);
    }

  }

}