import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/login/model/system_user_model.dart';
import 'package:qr_attend/services/firebase_services.dart';

import '../../../locator.dart';

List<SystemUserModel> systemUsers = [];

class SystemUsersViewModel extends BaseViewModel {
  final _firebaseServices = locator<FirebaseServices>();

  void getSystemUsers() async {
    if (systemUsers.isNotEmpty) {
      setState(ViewState.Idle);
      return;
    }
    Resource<List<SystemUserModel>> response =
        await _firebaseServices.getSystemUsers();
    switch (response.status) {
      case Status.SUCCESS:
        systemUsers.clear();
        systemUsers = response.data!;
        break;
      case Status.ERROR:
        break;
      default:
        print('wtf');
    }
    setState(ViewState.Idle);
  }

  void insert(int index, SystemUserModel user) {
    systemUsers.insert(index, user);
    setState(ViewState.Idle);
  }

  void deleteUser(int index) {
    _firebaseServices.deleteUser(systemUsers[index]);
    systemUsers.removeAt(index);
    setState(ViewState.Idle);
  }
}
