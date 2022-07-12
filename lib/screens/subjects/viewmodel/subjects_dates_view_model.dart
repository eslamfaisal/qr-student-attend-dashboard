import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/attends/model/attend_date_model.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
import 'package:qr_attend/services/firebase_services.dart';

import '../../../locator.dart';

class SubjectsDatesViewModel extends BaseViewModel {
  List<AttendDateModel> attendsDates = [];
  StreamSubscription? snapshot;

  final _firebaseServices = locator<FirebaseServices>();
  SubjectModel? selectedSubject;

  getSubjectsDates(SubjectModel subject, String type) async {
    selectedSubject = subject;
    var response =
        await _firebaseServices.getSubjectAllAttendDates(subject.id!, type);
    if (response.status == Status.SUCCESS) {
      attendsDates = response.data!;
    }
    setState(ViewState.Idle);
  }

  void delete(int index) {
    try {
      _firebaseServices.deleteSubjectDate(
          selectedSubject!.id!, attendsDates[index].id!);
      attendsDates.removeAt(index);
      setState(ViewState.Idle);
    } catch (e) {}
  }


}
