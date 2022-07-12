import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/attends/model/attend_model.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/login/model/system_user_model.dart';
import 'package:qr_attend/screens/subjects/model/category_model.dart';
import 'package:qr_attend/screens/system_users/viewmodel/system_users_view_model.dart';
import 'package:qr_attend/services/firebase_services.dart';

import '../../../locator.dart';
import '../../subjects/viewmodel/subjects_view_model.dart';

class SelectAttendTypeViewModel extends BaseViewModel {
  final _firebaseServices = locator<FirebaseServices>();

  List<SystemUserModel> allStudentUsersList = [];
  List<AttendModel> allAttendsList = [];

  SubjectModel? selectedSubjectModel;

  initSelection() {
    selectedSubjectModel = currentAllSubjects[0];
    setState(ViewState.Busy);
  }
  getAllAttends() async {
    systemUsers.where((user) => user.type == 'student').toList();
    var result = await _firebaseServices.getAllAttends();
    if (result.status == Status.SUCCESS) {
      allAttendsList = result.data!;
    }

    setState(ViewState.Idle);
  }

  void setSelctedSubject(SubjectModel? value) {
    selectedSubjectModel = value;
    setState(ViewState.Idle);
  }
}
