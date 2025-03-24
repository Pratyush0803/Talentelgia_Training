class PasswordValidation {
  String? passwordValidator(String password) {
    if (password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 8) {
      return "Password must be at least 8 characters";
    } else if (!RegExp(r'.*[0-9].*').hasMatch(password)) {
      return "Password must contain a number";
    } else if (!RegExp(r'.*[a-z].*').hasMatch(password)) {
      return "Password must contain a lowercase character";
    } else if (!RegExp(r'.*[A-Z].*').hasMatch(password)) {
      return "Password must contain an uppercase character";
    } else if (!RegExp(r'.*[@#$%^&+=].*').hasMatch(password)) {
      return "Password must contain a special character";
    }
    return null;
  }
}