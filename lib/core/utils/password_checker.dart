import 'package:imsmart_admin/core/utils/constants.dart';

class PasswordChecker {
  final bool hasUpperCase;
  final bool hasNumber;
  final bool hasLowerCase;
  final bool hasSpecialCharacter;
  final bool moreThanLen8;

  PasswordChecker({
    required this.hasUpperCase,
    required this.hasNumber,
    required this.hasLowerCase,
    required this.hasSpecialCharacter,
    required this.moreThanLen8,
  });

  factory PasswordChecker.init() => PasswordChecker(
        hasNumber: false,
        hasLowerCase: false,
        hasSpecialCharacter: false,
        hasUpperCase: false,
        moreThanLen8: false,
      );

  PasswordChecker copyWith({
    bool? hasUpperCase,
    bool? hasLowerCase,
    bool? hasNumber,
    bool? hasSpecialCharacter,
    bool? moreThanLen8,
  }) {
    return PasswordChecker(
      hasUpperCase: hasUpperCase ?? this.hasUpperCase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasLowerCase: hasLowerCase ?? this.hasLowerCase,
      hasSpecialCharacter: hasSpecialCharacter ?? this.hasSpecialCharacter,
      moreThanLen8: moreThanLen8 ?? this.moreThanLen8,
    );
  }

  PasswordChecker checkString(String input) {
    final bool hasUpperCase;
    final bool hasNumber;
    final bool hasSpecialCharacter;
    final bool hasLowerCase;
    final bool moreThanLen8;
    if (AppRegex.onlyNumbers.hasMatch(input)) {
      hasNumber = true;
    } else {
      hasNumber = false;
    }
    if (AppRegex.onlyUppercase.hasMatch(input)) {
      hasUpperCase = true;
    } else {
      hasUpperCase = false;
    }
    if (AppRegex.onlyLowercase.hasMatch(input)) {
      hasLowerCase = true;
    } else {
      hasLowerCase = false;
    }

    if (AppRegex.onlySpecialCharacter.hasMatch(input)) {
      hasSpecialCharacter = true;
    } else {
      hasSpecialCharacter = false;
    }
    if (input.length >= 8) {
      moreThanLen8 = true;
    } else {
      moreThanLen8 = false;
    }

    return PasswordChecker(
      hasNumber: hasNumber,
      hasSpecialCharacter: hasSpecialCharacter,
      hasUpperCase: hasUpperCase,
      hasLowerCase: hasLowerCase,
      moreThanLen8: moreThanLen8,
    );
  }

  @override
  operator ==(covariant PasswordChecker other) =>
      other.hasNumber == hasNumber &&
      other.hasUpperCase == hasUpperCase &&
      other.hasLowerCase == hasLowerCase &&
      other.moreThanLen8 == moreThanLen8 &&
      other.hasSpecialCharacter == hasSpecialCharacter;

  @override
  int get hashCode =>
      hasUpperCase.hashCode ^
      hasLowerCase.hashCode ^
      hasNumber.hashCode ^
      hasSpecialCharacter.hashCode ^
      moreThanLen8.hashCode;
}
