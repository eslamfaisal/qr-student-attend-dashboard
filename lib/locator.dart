import 'package:qr_attend/screens/categories/viewmodel/category_dialog_view_model.dart';
import 'package:qr_attend/screens/home/viewmodel/home_view_model.dart';
import 'package:qr_attend/screens/login/viewmodel/login_view_model.dart';
import 'package:qr_attend/screens/splash/view_model/splash_view_model.dart';
import 'package:qr_attend/services/firebase_services.dart';
import 'package:qr_attend/services/shared_pref_services.dart';
import 'package:get_it/get_it.dart';

import 'screens/categories/viewmodel/categories_view_model.dart';
import 'screens/countries/viewmodel/choose_countries_view_model.dart';
import 'screens/countries/viewmodel/countries_view_model.dart';
import 'screens/countries/viewmodel/country_dialog_view_model.dart';
import 'services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => FirebaseServices());
  locator.registerLazySingleton(() => SharedPrefServices());
  locator.registerLazySingleton(() => CountriesViewModel());
  locator.registerLazySingleton(() => CategoriesViewModel());
  locator.registerFactory(() => SplashViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => CategoryDialogViewModel());
  locator.registerFactory(() => CountryDialogViewModel());
  locator.registerFactory(() => ChooseCountriesViewModel());

  locator<NavigationService>();
  locator<SharedPrefServices>();
}