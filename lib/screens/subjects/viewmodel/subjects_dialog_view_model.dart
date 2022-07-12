import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
import 'package:qr_attend/services/firebase_services.dart';

import '../../../locator.dart';

class CategoryDialogViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final _firebaseServices = locator<FirebaseServices>();

  Future<Resource<SubjectModel>> updateAd(SubjectModel oldCategoryModel) async {
    setState(ViewState.Busy);

    if (formKey.currentState!.validate()) {
      SubjectModel updatedCategoryModel = SubjectModel(
        id: oldCategoryModel.id,
        name: titleController.value.text,
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

  Future<Resource<SubjectModel>> createNewAd() async {
    setState(ViewState.Busy);
    if (formKey.currentState!.validate()) {
      String subjectID =
          FirebaseFirestore.instance.collection("subjects").doc().id;
      SubjectModel subjectModel = SubjectModel(
        id: subjectID,
        name: titleController.value.text,
      );

      Resource<String> response =
          await _firebaseServices.createNewCategory(subjectModel);
      if (response.status == Status.SUCCESS) {
        setState(ViewState.Idle);
        return Resource(Status.SUCCESS, data: subjectModel);
      } else {
        return Resource(Status.ERROR, errorMessage: response.errorMessage);
      }
    } else {
      setState(ViewState.Idle);
      return Resource(Status.ERROR, errorMessage: tr('fill_all_fields'));
    }
  }
}
