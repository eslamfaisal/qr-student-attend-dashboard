import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_attend/routs/routing_data.dart';
import 'package:qr_attend/routs/routs_names.dart';
import 'package:qr_attend/screens/attends/view/select_attends_type_screen.dart';
import 'package:qr_attend/screens/login/view/login_screen.dart';
import 'package:qr_attend/screens/navigation/navigation_index.dart';
import 'package:qr_attend/screens/navigation/view/navigation_container.dart';
import 'package:qr_attend/screens/not_found_screen/not_found_screen.dart';
import 'package:qr_attend/screens/splash/splash_screen.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
import 'package:qr_attend/screens/subjects/view/subjects_dates_screen.dart';
import 'package:qr_attend/screens/subjects/view/subjects_screen.dart';
import 'package:qr_attend/screens/system_users/view/system_users_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var uriData = Uri.parse(settings.name!);

    var routingData = RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );

    print('RoutingName: ${routingData.route}');

    switch (routingData.route) {
      case RouteName.SPLASH:
        return _getPageRoute(SplashScreen(), settings);

      case RouteName.LOGIN:
        return _getPageRoute(LoginScreen(), settings);

      case RouteName.SUBJECTS_SCREEN:
        return _getPageRoute(
            NavigationContainer(const SubjectsScreen(), SUBJECTS_INDEX),
            settings);

      case RouteName.USERS_SCREEN:
        return _getPageRoute(
            NavigationContainer(const SystemUsersScreen(), SYSTEM_USERS_INDEX),
            settings);

      case RouteName.SELECT_ATTENDS_TYPE_SCREEN:
        return _getPageRoute(
            NavigationContainer(const SelectAttendsTypeScreen(), ATTENDS_INDEX),
            settings);

      case RouteName.SUBJECT_ATTENDS_SCREEN:
        SubjectModel subject = settings.arguments as SubjectModel;
        String type = routingData['type'];
        return _getPageRoute(
            NavigationContainer(
                SubjectsDatesScreen(subject, type), SUBJECTS_INDEX),
            settings);

      default:
        return _getPageRoute(const NotFoundScreen(), settings);
    }
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget? child;
  final String? routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
