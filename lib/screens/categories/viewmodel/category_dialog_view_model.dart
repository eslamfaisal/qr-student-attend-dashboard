import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/categories/model/category_model.dart';
import 'package:qr_attend/services/firebase_services.dart';

import '../../../locator.dart';

class CategoryDialogViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleARController = TextEditingController();
  TextEditingController titleENController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  final _firebaseServices = locator<FirebaseServices>();

  Future<Resource<CategoryModel>> updateAd(
      CategoryModel oldCategoryModel) async {
    setState(ViewState.Busy);



    if (formKey.currentState!.validate() ) {

      CategoryModel updatedCategoryModel = CategoryModel(
        id: oldCategoryModel.id,
        name_en: titleENController.value.text,
        name_ar: titleARController.value.text,
        priority: double.parse(priorityController.value.text),
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

  Future<Resource<CategoryModel>> createNewAd() async {
    setState(ViewState.Busy);
    if (formKey.currentState!.validate()) {

      String categoryID =
          FirebaseFirestore.instance.collection("categories").doc().id;
      CategoryModel categoryModel = CategoryModel(
        id: categoryID,
        name_en: titleENController.value.text,
        name_ar: titleARController.value.text,
        priority: double.parse(priorityController.value.text),
      );

      Resource<String> response =
          await _firebaseServices.createNewCategory(categoryModel);
      if (response.status == Status.SUCCESS) {
        setState(ViewState.Idle);
        return Resource(Status.SUCCESS, data: categoryModel);
      } else {
        return Resource(Status.ERROR, errorMessage: response.errorMessage);
      }
    } else {
      setState(ViewState.Idle);
      return Resource(Status.ERROR, errorMessage: tr('fill_all_fields'));
    }
  }

}
