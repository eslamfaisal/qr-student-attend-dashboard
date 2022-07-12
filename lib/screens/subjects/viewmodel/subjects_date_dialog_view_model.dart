import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/attends/model/attend_date_model.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
import 'package:qr_attend/services/firebase_services.dart';

import '../../../locator.dart';

class CategoryDateDialogViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  var attendType = 'Lecture';
  var subjectID = '';

  TextEditingController dateController = TextEditingController();
  TextEditingController sectionNumberController = TextEditingController();

  final _firebaseServices = locator<FirebaseServices>();

  void initSubjectAttendDate(String attendType, String subjectID) {
    this.attendType = attendType;
    this.subjectID = subjectID;
  }

  Future<Resource<SubjectModel>> updateAd(SubjectModel oldCategoryModel) async {
    setState(ViewState.Busy);

    if (formKey.currentState!.validate()) {
      SubjectModel updatedCategoryModel = SubjectModel(
        id: oldCategoryModel.id,
        name: dateController.value.text,
      );

      Resource<String> response =
          await _firebaseServices.updateCategoryModel(updatedCategoryModel);
      if (response.status == Status.SUCCESS) {
        setState(ViewState.Idle);
        return Resource(Status.SUCCESS, data: updatedCategoryModel);
      } else {
        return Resource(Status.ERROR, errorMessage: response.errorMessage);
      }
    } else {
      setState(ViewState.Idle);
      return Resource(Status.ERROR, errorMessage: tr('fill_all_fields'));
    }
  }

  Future<Resource<AttendDateModel>> create() async {
    setState(ViewState.Busy);
    if (formKey.currentState!.validate()) {
      String attendId =
          FirebaseFirestore.instance.collection("subjects").doc().id;

      AttendDateModel attendDate = AttendDateModel(
        id: attendId,
        date: dateController.value.text,
        type: attendType,
        sectionNumber:
            attendType == 'Section' ? sectionNumberController.value.text : null,
      );

      Resource<String> response =
          await _firebaseServices.createAttendDate(attendDate, subjectID);
      if (response.status == Status.SUCCESS) {
        setState(ViewState.Idle);
        return Resource(Status.SUCCESS, data: attendDate);
      } else {
        return Resource(Status.ERROR, errorMessage: response.errorMessage);
      }
    } else {
      setState(ViewState.Idle);
      return Resource(Status.ERROR, errorMessage: tr('fill_all_fields'));
    }
  }

}
