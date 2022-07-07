import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';


extension BuildContextEasyLocalizationExtension on BuildContext {
  /// Get current locale
  Locale get locale => EasyLocalization.of(this)!.locale;

  /// Change app locale
  Future<void> setLocale(Locale val) async =>
      EasyLocalization.of(this)!.setLocale(val);

  /// Old Change app locale
  @Deprecated(
      'This is the func used in the old version of EasyLocalization. The modern func is `setLocale(val)` . '
          'This feature was deprecated after v3.0.0')
  set locale(Locale val) => EasyLocalization.of(this)!.setLocale(val);

  /// Get List of supported locales.
  List<Locale> get supportedLocales =>
      EasyLocalization.of(this)!.supportedLocales;

  /// Get fallback locale
  Locale? get fallbackLocale => EasyLocalization.of(this)!.fallbackLocale;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  /// return
  /// ```dart
  ///   delegates = [
  ///     delegate
  ///     GlobalMaterialLocalizations.delegate,
  ///     GlobalWidgetsLocalizations.delegate,
  ///     GlobalCupertinoLocalizations.delegate
  ///   ],
  /// ```
  List<LocalizationsDelegate> get localizationDelegates =>
      EasyLocalization.of(this)!.delegates;

  /// Clears a saved locale from device storage
  Future<void> deleteSaveLocale() =>
      EasyLocalization.of(this)!.deleteSaveLocale();

  /// Getting device locale from platform
  Locale get deviceLocale => EasyLocalization.of(this)!.deviceLocale;

  /// Reset locale to platform locale
  Future<void> resetLocale() => EasyLocalization.of(this)!.resetLocale();
}
