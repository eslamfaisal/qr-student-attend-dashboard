import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_attend/models/resources.dart';
import 'package:qr_attend/models/status.dart';
import 'package:qr_attend/screens/attends/model/attend_model.dart';
import 'package:qr_attend/screens/countries/model/country_model.dart';
import 'package:qr_attend/screens/subjects/model/subject_model.dart';
import 'package:qr_attend/services/shared_pref_services.dart';
import 'package:qr_attend/utils/constants.dart';

import '../locator.dart';
import '../screens/attends/model/attend_date_model.dart';
import '../screens/login/model/system_user_model.dart';
import '../utils/shared_preferences_constants.dart';

class FirebaseServices {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  User? getCurrentUserData() {
    return auth.currentUser;
  }

  void signOut() {
    auth.signOut();
  }

  Future<Resource<UserCredential>> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Resource(Status.SUCCESS, data: userCredential);
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<SystemUserModel>> getSystemUserProfile(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> value =
          await db.collection('system_users').doc(userId).get();
      if (value.exists) {
        SystemUserModel userModel = SystemUserModel.fromJson(value.data()!);

        print('userModel: ${userModel.name}');
        await locator<SharedPrefServices>().saveBoolean(LOGGED_IN, true);
        await locator<SharedPrefServices>()
            .saveString(USER_DETAILS, jsonEncode(userModel.toJson()));

        return Resource(Status.SUCCESS, data: userModel);
      } else {
        return Resource(Status.ERROR, errorMessage: tr('user_not_found'));
      }
    } catch (e) {
      print('eeror in getSystemUserProfile: $e');
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<SystemUserModel>> createNewSystemUser(String id, String name,
      String email, String password, String type) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Resource<SystemUserModel> storeUserResponse = await storeSystemUserInfo(
          id, userCredential.user!, name, password, type);
      if (storeUserResponse.status == Status.SUCCESS) {
        return Resource(Status.SUCCESS, data: storeUserResponse.data);
      } else {
        return Resource(Status.ERROR,
            errorMessage: storeUserResponse.toString());
      }
    } on FirebaseAuthException catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<SystemUserModel>> storeSystemUserInfo(
      String id, User data, String name, String password, String type) async {
    SystemUserModel model = SystemUserModel(
      id: id,
      name: name,
      email: data.email,
      password: password,
      type: type,
    );
    try {
      await db.collection("system_users").doc(id).set(model.toJson());
      return Resource(Status.SUCCESS, data: model);
    } on FirebaseAuthException catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<List<SubjectModel>>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> response =
          await db.collection('subjects').get();

      List<SubjectModel> categoriesList = response.docs
          .map((doc) => SubjectModel.fromJson(doc.data()))
          .toList();

      print('categoriesList: ${categoriesList.length}');
      return Resource(Status.SUCCESS, data: categoriesList);
    } catch (e) {
      print('categoriesList:error ${e}');
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<SubjectModel>> getCategoryDetails(String id) async {
    try {
      var response = await db.collection('subjects').doc(id).get();
      var category = SubjectModel.fromJson(response.data()!);
      return Resource(Status.SUCCESS, data: category);
    } catch (e) {
      print('errrrorr ${e.toString()}');
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  void deleteCouponOffer(String id) {
    db
        .collection('coupons_and_offers')
        .doc(id)
        .delete()
        .then((value) => print('ad deleted'));
  }

  void deleteSubject(String id) {
    db
        .collection('subjects')
        .doc(id)
        .delete()
        .then((value) => print('ad deleted'));
  }

  void deleteSubjectDate(String subjectId, String id) {
    db
        .collection('subjects')
        .doc(subjectId)
        .collection('attend_date')
        .doc(id)
        .delete()
        .then((value) => print('ad deleted'));
  }

  void deleteCountry(String id) {
    db
        .collection('countries')
        .doc(id)
        .delete()
        .then((value) => print('ad deleted'));
  }

  void deleteStore(String id) {
    db
        .collection('stores')
        .doc(id)
        .delete()
        .then((value) => print('ad deleted'));
  }

  Future<Resource<String>> createNewCategory(SubjectModel categoryModel) async {
    try {
      await db
          .collection('subjects')
          .doc(categoryModel.id)
          .set(categoryModel.toJson());
      return Resource(Status.SUCCESS, data: tr('created_successfully'));
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<String>> createNewCountry(CountryModel categoryModel) async {
    try {
      await db
          .collection('countries')
          .doc(categoryModel.id)
          .set(categoryModel.toJson());
      return Resource(Status.SUCCESS, data: tr('created_successfully'));
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<String>> updateCategoryModel(
      SubjectModel categoryModel) async {
    try {
      await db
          .collection('subjects')
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
      return Resource(Status.SUCCESS, data: tr('updated_successfully'));
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<String>> updateCountryModel(
      CountryModel categoryModel) async {
    try {
      await db
          .collection('countries')
          .doc(categoryModel.id)
          .update(categoryModel.toJson());
      return Resource(Status.SUCCESS, data: tr('updated_successfully'));
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<List<SystemUserModel>>> getSystemUsers() async {
    List<SystemUserModel> systemUsers = [];
    try {
      await db.collection("system_users").get().then((value) {
        for (var element in value.docs) {
          systemUsers.add(SystemUserModel.fromJson(element.data()));
        }
      });
      return Resource(Status.SUCCESS, data: systemUsers);
    } on FirebaseAuthException catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<List<AttendModel>>> getAllAttends(
      String subjectID, String type, String section) async {
    List<AttendModel> attends = [];
    print('getAllAttends: $subjectID, $type, $section');
    try {
      if (type == 'Section') {
        await db
            .collection("attends")
            .where('subject_id', isEqualTo: subjectID)
            .where('attend_type', isEqualTo: type)
            .where('section_number', isEqualTo: section)
            .get()
            .then((value) {
          for (var element in value.docs) {
            attends.add(AttendModel.fromJson(element.data()));
          }
        });
      } else {
        await db
            .collection("attends")
            .where('subject_id', isEqualTo: subjectID)
            .where('attend_type', isEqualTo: type)
            .get()
            .then((value) {
          for (var element in value.docs) {
            attends.add(AttendModel.fromJson(element.data()));
          }
        });
      }
      print('attends: ${attends.length}');
      return Resource(Status.SUCCESS, data: attends);
    } on Exception catch (e) {
      print('errrrorr ${e.toString()}');
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<List<AttendDateModel>>> getSubjectAttendDates(
      String subjectId, String type, int selectedSectionNumber) async {
    List<AttendDateModel> dates = [];
    try {
      if (type == 'Section') {
        await db
            .collection("subjects")
            .doc(subjectId)
            .collection("attend_date")
            .where("type", isEqualTo: type)
            .where("section", isEqualTo: selectedSectionNumber.toString())
            .get()
            .then((value) {
          for (var element in value.docs) {
            dates.add(AttendDateModel.fromJson(element.data()));
          }
        });
      } else {
        await db
            .collection("subjects")
            .doc(subjectId)
            .collection("attend_date")
            .where("type", isEqualTo: type)
            .get()
            .then((value) {
          for (var element in value.docs) {
            dates.add(AttendDateModel.fromJson(element.data()));
          }
        });
      }
      return Resource(Status.SUCCESS, data: dates);
    } on FirebaseAuthException catch (e) {
      print('error ${e.toString()}');
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<List<AttendDateModel>>> getSubjectAllAttendDates(
      String subjectId, String type) async {
    List<AttendDateModel> dates = [];
    try {
      await db
          .collection("subjects")
          .doc(subjectId)
          .collection("attend_date")
          .where("type", isEqualTo: type)
          .get()
          .then((value) {
        for (var element in value.docs) {
          dates.add(AttendDateModel.fromJson(element.data()));
        }
      });
      return Resource(Status.SUCCESS, data: dates);
    } on FirebaseAuthException catch (e) {
      print('error ${e.toString()}');
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  Future<Resource<UserCredential>> reLogin() async {
    try {
      await auth.signOut();
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: currentLoggedInUserData.email!,
          password: currentLoginPassword);
      return Resource(Status.SUCCESS, data: userCredential);
    } catch (e) {
      return Resource(Status.ERROR, errorMessage: e.toString());
    }
  }

  void deleteUser(SystemUserModel systemUser) async {
    db
        .collection("system_users")
        .doc(systemUser.id)
        .delete()
        .then((value) => print('deleted'));
  }
}
