import 'package:safe_hunt/utils/extenions/email_checker.dart';

RegExp phoneNumberPattern = RegExp(r'^\+1\(\d{3}\) \d{3}-\d{4}$');
RegExp phoneNumberPatternLogin = RegExp(r'^\(\d{3}\) \d{3}-\d{4}$');

class CommonFieldValidators {
  ///Auth
  static String? emailValidator(String? v) {
    if (v!.isEmpty) {
      return 'Email field can\'t be empty.';
    } else if (!v.isValidEmail()) {
      return 'Please enter valid email address.';
    }
    return null;
  }

  static String? phoneFieldValidatorLogin(String? v) {
    if (v!.isEmpty) {
      return "${"Phone number"} field can't be empty.";
    } else if (v.length < 15) {
      return "Invalid ${"Phone number"}.";
    }
    return null;
  }

  static String? phoneFieldValidator2(String? v) {
    if (v!.isEmpty) {
      return 'Phone field can\'t be empty.';
    }
    // Check if the entered value matches the regex pattern
    // if (!phoneNumberPattern.hasMatch(v)) {
    //   return 'Please enter a valid phone number';
    // }

    return null;
  }

  static String? validateEmptyOrNull({String? value, String? label}) {
    if (value == null || value.isEmpty) {
      return '$label field can\'t be empty.';
    }

    return null;
  }

  static String? validateDropDown({
    String? value,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please select an option.';
    }

    return null;
  }

  /// Password Validator
  static String? passwordValidator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Password field can\'t be empty.';
    }
    if (v.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(v)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(v)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(v)) {
      return 'Password must contain at least one number.';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(v)) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  /// Confirm Password Validator
  static String? confirmPasswordValidator(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password field can\'t be empty.';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }
}
