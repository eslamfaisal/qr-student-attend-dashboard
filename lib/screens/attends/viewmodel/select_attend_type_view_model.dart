import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/attends/model/attend_date_model.dart';
import 'package:qr_attend/screens/attends/model/attend_model.dart';
import 'package:qr_attend/screens/attends/model/attends_type.dart';
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

  List<AttendDateModel> subjectAttendsDateList = [];
  AttendDateModel? selectedAttendDate;

  SubjectModel? selectedSubjectModel;
  int selectedSectionNumber = 1;
  var sectionsNumbers = [1, 2, 3];

  AttendType selectedAttendType = AttendType.Lecture;
  var attendTypes = [AttendType.Lecture, AttendType.Section];

  initSelection() {
    selectedSubjectModel = currentAllSubjects[0];
    allStudentUsersList =
        systemUsers.where((user) => user.type == 'student').toList();
    setState(ViewState.Busy);
    getSubjectAttendsAndItsDate();
  }

  getSubjectAttendsAndItsDate() async {
    var attends = await _firebaseServices.getAllAttends(
      selectedSubjectModel!.id!,
      selectedAttendType.name,
      selectedSectionNumber.toString(),
    );
    if (attends.status == Status.SUCCESS) {
      allAttendsList = attends.data!;
      print('allAttendsList = $allAttendsList');
    }

    print('getSubjectAttendsDate = ${selectedAttendType.name}');
    var attendsDates = await _firebaseServices.getSubjectAttendDates(
        selectedSubjectModel!.id!,
        selectedAttendType.name,
        selectedSectionNumber);
    if (attendsDates.status == Status.SUCCESS) {
      subjectAttendsDateList = attendsDates.data!;
      print('subjectAttendsDateList = $subjectAttendsDateList');
    }

    setState(ViewState.Idle);
  }

  void setSelectedSubject(SubjectModel? value) {
    selectedSubjectModel = value;
    setState(ViewState.Idle);
    getSubjectAttendsAndItsDate();
  }

  void setSelectedAttend(AttendType? value) {
    selectedAttendType = value!;
    getSubjectAttendsAndItsDate();
  }

  void setSelectedSectionNumber(int? value) {
    selectedSectionNumber = value!;
    setState(ViewState.Idle);
    getSubjectAttendsAndItsDate();
  }

  void showDate() {}
}
