//Encapsulation

//class BankAccount {
//    private var balance = 0
//
//    fun deposit(amount: Int) {
//        if (amount > 0) {
//            balance += amount
//        }
//    }
//
//    fun withdraw(amount: Int) {
//        if (amount in 1..balance) {
//            balance -= amount
//            println("Your withdrawn amount is : $amount")
//        }
//    }
//    fun getBalance():Int{
//        return balance
//    }
//}
//
//fun main() {
//    val myAccount = BankAccount()
//    println("Your current Balance is : " + myAccount.getBalance())
//    myAccount.deposit(10000)
//    println("Your current Balance is : " + myAccount.getBalance())
//    myAccount.withdraw(6000)
//    println("Your current Balance is : " + myAccount.getBalance())
//}

//-----------------------------------------------------Question 2
//Create a class Rectangle with:
//Private properties length and width.
//Public methods:
//setLength(value: Int) and setWidth(value: Int) to update the dimensions, but only if the value is positive.
//getArea() to return the area of the rectangle.
//getPerimeter() to return the perimeter of the rectangle.


//class Rectangle{
//    private var length = 0
//    private var width = 0
//    fun setLength(value:Int){
//        if (value > 0){
//            length = value
//        }
//    }
//    fun setWidth(value:Int){
//        if (value > 0){
//            width = value
//        }
//    }
//    fun getArea():Int{
//        return length * width
//    }
//    fun getPerimeter():Int{
//        return 2*(length + width)
//    }
//}
//fun main(){
//    val myRectangle = Rectangle()
//    myRectangle.setLength(13)
//    myRectangle.setWidth(20)
//    println("Area of the rectangle is : " + myRectangle.getArea())
//    println("Perimeter of the rectangle is : " + myRectangle.getPerimeter())
//}

//----------------------------------------------Question 3
//Create a class Employee with:
//Private properties name, age, and salary.
//Public methods:
//setName(name: String) and setAge(age: Int) to set the values, but age should be between 18 and 65.
//getDetails() to return a formatted string containing the employee's details.
//A bonus() method that calculates a 10% bonus of the salary but keeps the actual salary private.

class MyEmployee{
    private var name:String = ""
    private var age:Int = 0
    private var salary:Double = 0.0

    fun setName(name:String){
        this.name = name
    }
    fun setAge(age:Int){
        if (age in 18..65){
            this.age = age
        }
    }
    fun setSalary(salary : Double){
        if (salary > 0){
            this.salary = salary
        }
    }
    fun getDetails():String{
        return " Name: $name \n Age: $age \n Salary: $salary"
    }
    fun bonus():Double{
        return salary * 0.10
    }
}

fun main() {
    val employee = MyEmployee()
    employee.setName("Pratyush Kumar Jena")
    employee.setAge(21)
    employee.setSalary(15000.0)
    println(employee.getDetails())
    println(" Bonus: " + employee.bonus())
}