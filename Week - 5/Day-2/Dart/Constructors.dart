//Default Constructor
// class Student{
//   Student(){
//     print("Hi students");
//   }
// }
// void main() {
//   Student std = new Student();
// }

//Parameterized Constructor
class Student{
  Student(var name, var rollNo){
    print("Name: $name\n"
        "Roll no: $rollNo");
  }
}
void main(){
  Student myStudent = new Student("Bubu", 21);
}