import 'package:flutter/widgets.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/utils/context_extentions.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  SwitchState _switchState = SwitchState.CLOSE;

  SwitchState get switchState => _switchState;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void switchLanguage(bool state, BuildContext context) async {
    state == true
        ? _switchState = SwitchState.OPEN
        : _switchState = SwitchState.CLOSE;

    notifyListeners();

    if (context.locale == const Locale('ar', 'EG')) {
      context.setLocale(const Locale('en', 'US'));
    } else {
      context.setLocale(const Locale('ar', 'EG'));
    }
  }
}
