import 'package:qr_attend/screens/attends/model/attend_model.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/login/model/system_user_model.dart';
import 'package:qr_attend/screens/system_users/viewmodel/system_users_view_model.dart';
import 'package:qr_attend/services/firebase_services.dart';

import '../../../locator.dart';

class SelectAttendTypeViewModel extends BaseViewModel {
  final _firebaseServices = locator<FirebaseServices>();

  List<SystemUserModel> allStudentUsersList = [];
  List<AttendModel> allAttendsList = [];

  getAllAttends() async {
    allStudentUsersList = systemUsers.where((user) => user.type == 'student').toList();
    var result = await _firebaseServices.getAllAttends();
  }


}
