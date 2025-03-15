void main(){
  var num1 = 21.5;
  var num2 = 10;

  print(num1.abs());//Retrurns the distance from ZERO

  print(num1.ceil());//Returns the neares integer

  print(num1.floor());//Returns the greatest integer that is less than or equal to that number

  print(num1.compareTo(num2));//Returns 1 if num1 is greater than num2, returns -1 if num1 is less than num2
  print(num2.compareTo(num1));

  print(num1.round());//Returns the nearest integer to that number,
  print(num2.round()); // rounding up if the fractional part is 0.5 or greater

  print(num2.toDouble());//Returns the Double no of the num2

  print(num1.toInt());//Returns the Integer no of the num1

  print(num1.toString());//Returns the String of the num1

  print(num1.toString());//It is same as toInt()

}