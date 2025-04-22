class LoginValidator {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter your password';
    }
    if (value.length < 6) {
      return 'Minimum 6 characters required';
    }
    return null;
  }
}