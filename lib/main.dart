import 'package:qr_attend/locator.dart';
import 'package:qr_attend/routs/app_router.dart';
import 'package:qr_attend/routs/routs_names.dart';
import 'package:qr_attend/services/navigation_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  await configureApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      startLocale: const Locale('ar', 'EG'),
      fallbackLocale: const Locale('ar', 'EG'),
      saveLocale: true,
      path: 'assets/translations',
      child: MyApp(),
    ),
  );
}

Future configureApp() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  setupLocator();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'QR Attend',
      theme: ThemeData(
          primaryColor: const Color(0xFFFD5F00),
          primarySwatch: Colors.deepOrange,
          fontFamily: 'Cairo',
      ),
      initialRoute: RouteName.SUBJECTS_SCREEN,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
