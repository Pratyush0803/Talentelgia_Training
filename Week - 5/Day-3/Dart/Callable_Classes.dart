class Employee{
  String call(String name, int salary){
    return("The employee name is $name and salary is $salary");
  }
}
void main(){
  Employee myEmployee = new Employee();
  var details = myEmployee("Pratyush",15000);
  print(details);
}