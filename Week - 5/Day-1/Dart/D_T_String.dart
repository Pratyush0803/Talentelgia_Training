void main(){

  //------------------------Multi kine String:
  //
  // //Multi Line Using Single Quotes
  // String myDetails = '''
  // My Details:
  // Hello Everyone,
  //    My Name is Pratyush
  //    Iam from Puri, Odisha
  //    My 21 years old
  //    Now Iam Intern In Talentelgia Technologies Pvt.Ltd
  // ''';
  // print(myDetails);
  //
  // // ------------------Multi Line Using Double Quotes
  // String myJobDetails = """
  // Job Details:
  // Name: Pratyush Kumar Jena
  // Age: 21
  // DOB: 08.10.2003
  // Job Tittle: Software Intern
  // Technology: Android and Flutter
  // Salary: 15000
  // """;
  //
  // print(myJobDetails);


  var myLine = "Hello, Everyone";
  var myLine2 = 'Hello, Talentelegians!';
  var myLine3 = "$myLine and $myLine2";

  print(myLine);
  print(myLine2);
  print(myLine3);
  print(myLine + myLine2);

  //Raw String Special Character Wont Work Here
  var myRawLine = r"Welcome and $myLine3";
  print(myRawLine);

//--------------STRING METHODS--------------------
  print(myLine.isEmpty);//Returns true if Empty
  print(myLine.isNotEmpty);//Returns true if Not Empty

  print(myLine.length);//Returns the length of the string including space, tab and newline characters

  print(myLine.toLowerCase());//Converts all characters in this string to lower case.
  print(myLine.toUpperCase());//Converts all characters in this string to upper case.

  print(myLine.trim());//Returns the string without any leading and trailing whitespace.

  print(myLine.compareTo(myLine2));//Compares this object to another.

  print(myLine3.replaceAll("Hello", "Hi"));//Replaces all substrings that match the specified pattern with a given value.
  
  print(myLine3.replaceAll("Hello", "Hi"));//Replaces all substrings that match the specified pattern with a given value.
}