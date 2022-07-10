import 'package:easy_localization/easy_localization.dart';

enum UserType {
  student,
  doctor,
  assistant,
  dahsboard,
}

extension UserTypeExtensions on UserType {

  String getTranslatedName() {
    switch (this) {
      case UserType.student:
        return tr('student');

      case UserType.doctor:
        return tr('doctor');

      case UserType.assistant:
        return tr('assistant');

      case UserType.dahsboard:
        return tr('dahsboard');

      default:
        return 'Unknown';
    }

  }

  String getType() {

    switch (this) {
      case UserType.student:
        return ('student');

      case UserType.doctor:
        return ('doctor');

      case UserType.assistant:
        return ('assistant');

      case UserType.dahsboard:
        return ('dahsboard');

      default:
        return 'Unknown';
    }

  }

}
