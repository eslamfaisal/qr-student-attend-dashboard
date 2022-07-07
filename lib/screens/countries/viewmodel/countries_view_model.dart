import 'dart:async';

import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/countries/model/country_model.dart';
import 'package:qr_attend/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../locator.dart';

List<CountryModel> currentAllCountriesList = [];
StreamSubscription? snapshot;

class CountriesViewModel extends BaseViewModel {
  final _firebaseServices = locator<FirebaseServices>();
  final formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  getCountries() async {
    if (snapshot != null) {
      setState(ViewState.Idle);
      return;
    }
    snapshot = FirebaseFirestore.instance
        .collection('countries')
        .snapshots()
        .listen((event) {
      print('getCountries snapshot = ${event.docs.length}');
      currentAllCountriesList =
          event.docs.map((doc) => CountryModel.fromJson(doc.data())).toList();
      setState(ViewState.Idle);
    });
  }

  void deleteCountry(int index) {
    try {
      _firebaseServices.deleteCountry(currentAllCountriesList[index].id!);
      currentAllCountriesList.removeAt(index);
      setState(ViewState.Idle);
    } catch (e) {}
  }
}
