import 'dart:async';

import 'package:qr_attend/enums/screen_state.dart';
import 'package:qr_attend/screens/base_view_model.dart';
import 'package:qr_attend/screens/subjects/model/category_model.dart';
import 'package:qr_attend/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../locator.dart';

List<SubjectModel> currentAllCategories = [];
StreamSubscription? snapshot;

class SubjectsViewModel extends BaseViewModel {
  final _firebaseServices = locator<FirebaseServices>();

  List<SubjectModel> selectedCategoriesList = [];
  List<SubjectModel> oldSelectedCategories = [];

  getSubjects() async {
    if (snapshot != null) {
      setState(ViewState.Idle);
      return;
    }
    snapshot = FirebaseFirestore.instance
        .collection('subjects')
        .snapshots()
        .listen((event) {
      print('getCategories snapshot = ${event.docs.length}');
      currentAllCategories =
          event.docs.map((doc) => SubjectModel.fromJson(doc.data())).toList();
      setState(ViewState.Idle);
    });
  }

  void initOldSelectedCategories() {
    oldSelectedCategories.clear();
    for (var old in oldSelectedCategories) {
      selectedCategoriesList.add(currentAllCategories
          .where((country) => country.id! == old.id!)
          .first);
    }
  }

  void delete(int index) {
    try {
      _firebaseServices.deleteCategory(currentAllCategories[index].id!);
      currentAllCategories.removeAt(index);
      setState(ViewState.Idle);
    } catch (e) {}
  }

  void onCountrySelected(SubjectModel country) {
    if (selectedCategoriesList.contains(country)) {
      selectedCategoriesList.remove(country);
    } else {
      selectedCategoriesList.add(country);
    }

    if (selectedCategoriesList.length == currentAllCategories.length) {
      allSelected = true;
    } else {
      allSelected = false;
    }
    setState(ViewState.Idle);
  }

  bool allSelected = false;

  void setAllSelected(bool? value) {
    allSelected = value ?? false;
    selectedCategoriesList.clear();
    if (allSelected) {
      selectedCategoriesList.addAll(currentAllCategories);
    }
    setState(ViewState.Idle);
  }
}
