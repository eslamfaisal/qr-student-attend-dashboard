import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/countries/model/country_model.dart';
import 'package:qr_attend/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../locator.dart';

class CountryDialogViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleARController = TextEditingController();
  TextEditingController titleENController = TextEditingController();
  final _firebaseServices = locator<FirebaseServices>();

  Future<Resource<CountryModel>> updateCountry(
      CountryModel oldCategoryModel) async {
    setState(ViewState.Busy);

    if (formKey.currentState!.validate()) {

      CountryModel updatedCategoryModel = CountryModel(
        id: oldCategoryModel.id,
        name_en: titleENController.value.text,
        name_ar: titleARController.value.text,
      );

      Resource<String> response =
          await _firebaseServices.updateCountryModel(updatedCategoryModel);
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

  Future<Resource<CountryModel>> createNewCountry() async {
    setState(ViewState.Busy);
    if (formKey.currentState!.validate()) {

      String adID = FirebaseFirestore.instance.collection("countries").doc().id;
      CountryModel categoryModel = CountryModel(
        id: adID,
        name_en: titleENController.value.text,
        name_ar: titleARController.value.text,
      );

      Resource<String> response =
          await _firebaseServices.createNewCountry(categoryModel);
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
