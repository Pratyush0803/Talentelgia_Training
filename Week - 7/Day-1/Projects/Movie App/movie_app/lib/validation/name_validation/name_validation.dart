class NameValidation{
  String? nameValidator(String? name){
      if (name!.isEmpty) {
        return "Name can't be empty.";
      } else if (name.length < 2) {
        return "Name must be at least 2 characters long.";
      } else if (name.length >= 30) {
        return "Name can't be more than 30 characters";
      } else if (!RegExp(
        r'^[A-Z][a-zA-Z]*( [A-Z][a-zA-Z]*)*$',
      ).hasMatch(name)) {
        return "Name must start with a capital letter.";
      } else if (name.contains(RegExp(r" {3,}"))) {
        return "There can't be more than 2 spaces between words.";
      }
      return null;
  }
}