class EmailValidation{
  String? emailValidator(String? email){
    if(email!.isEmpty){
      return "Email can't be empty.";
    }else if (!RegExp(r'^[a-z0-9]+(?:[._-][a-z0-9]+)*@[a-z0-9]+(?:[-.][a-z0-9]+)*\.[a-z]{2,}$').hasMatch(email)){
      return "Invalid email, Enter a valid email.";
    }
    return null;
  }
}