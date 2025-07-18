class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    // Basic email regex validation
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateText(String? value, {String? fieldName, int minLength = 1}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} cannot be empty';
    }
    if (value.length < minLength) {
      return '${fieldName ?? 'Field'} must be at least $minLength characters long';
    }
    return null;
  }
}