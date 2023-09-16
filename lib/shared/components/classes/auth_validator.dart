import 'package:email_validator/email_validator.dart';
import 'package:regexed_validator/regexed_validator.dart';

String? isEmailValid(String? text) {
  if (text == null || text.trim().isEmpty) {
    return 'Email is required!';
  }
  if (!EmailValidator.validate(text.trim())) {
    return 'Email in not valid';
  }
  return null;
}

String? isFieldEmpty(String? text) {
  if (text == null || text.trim().isEmpty) {
    return 'Field is required!';
  }
  return null;
}

String? isFieldEmpty2(String? text) {
  if (text == null || text.trim().isEmpty) {
    return 'Required!';
  }
  return null;
}

String? isPasswordValid(String? text) {
  if (text == null || text.trim().isEmpty) {
    return "Password is required!";
  } else if (text.trim().length < 8) {
    return "Password must be at least 8 characters long";
  }
  return null;
}

String? isPasswordValid2(String? text, String? other) {
  if (text == null || text.trim().isEmpty) {
    return "Password is required!";
  } else if (text.trim().length < 8) {
    return "Password must be at least 8 characters long";
  } else if (text.trim() != other.toString().trim()) {
    return "Password doesn't match";
  }
  return null;
}

String? isUrlValid(String? text) {
  if (text == null || text.trim().isEmpty) {
    return 'Field is required!';
  }
  if (!validator.url(text.trim())) {
    return 'Url in not valid';
  }
  return null;
}

String? isUrlValid2(String? text) {
  if (text != null && text.isNotEmpty && !validator.url(text.trim())) {
    return 'Url in not valid';
  }
  return null;
}
