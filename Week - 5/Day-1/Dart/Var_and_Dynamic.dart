void main(){
  var myDetails1 = "Pratyush";
  dynamic myDetails2 = 21;

  print("Name: ${myDetails1}");
  print("Age: ${myDetails2}");
  //After reassigning variable data

//   myDetails1 = 21;    //Its type cant change because its "var"

  myDetails2 = "Pratyush";      //Its type can change because its "dynamic"

  print("Name: ${myDetails1}");
  print("Age: ${myDetails2}");

}