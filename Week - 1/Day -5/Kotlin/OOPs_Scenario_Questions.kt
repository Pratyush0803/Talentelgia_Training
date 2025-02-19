//________________Question no-1
//class BankAccount{
//    var accountNumber:Long = 0
//    var accountHolderName:String = ""
//    private var balance:Double = 0.0
//    fun deposit(amount:Double){
//        if (amount>0){
//            balance += amount
//            println("Hello $accountHolderName amount of $amount is deposited to your account")
//            println("Your current balance is $amount")
//        }else{
//            println("Please deposit positive amount")
//        }
//        }
//    fun withdraw(amount:Double){
//        if (amount<= balance){
//            balance -= amount
//            println("Hello $accountHolderName amount of $amount is withdrawn from your account")
//            println("Your current balance is $amount")
//        }
//    }
//    }
//
//fun main() {
//    val myAccount = BankAccount()
//    myAccount.accountNumber = 919827492246
//    myAccount.accountHolderName = "Pratyush"
//    myAccount.deposit(10000.0)
//    myAccount.withdraw(5000.0)
//}



//_________________Question no-2
//open class Employee{
//    var name:String = ""
//    var salary:Double = 0.0
//}
//class Manger : Employee() {
//    var bonus:Double = 0.0
//    fun displayInfo (){
//        println(name)
//        println("salary: $salary₹")
//        println("Bonus: $bonus₹")
//    }
//}
//class Developer : Employee(){
//    var programmingLanguage:String = ""
//    fun displayInfo (){
//        println(name)
//        println("Programming Language: $programmingLanguage")
//        println("Salary: $salary₹")
//    }
//}
//
//fun main() {
//    println("Manager Details:")
//    val manager = Manger()
//    manager.name = "Ashish Khorana"
//    manager.salary= 7000000.0
//    manager.bonus = 100000.0
//    manager.displayInfo()
//
//    println()
//
//    println("Developer Details:")
//    val developer = Developer()
//    developer.name = "Pratyush Kumar Jena"
//    developer.salary = 15000.0
//    developer.programmingLanguage ="Kotlin"
//    developer.displayInfo()
//}


//___________________Question No-3
// Scenario:
//Create a base class Vehicle with:
//
//Properties: brand, model, and year.
//Method displayInfo() to print vehicle details.
//Create subclasses Car and Motorcycle, each with an additional unique property:
//
//Car: numberOfDoors
//Motorcycle: hasSidecar (Boolean)
//Override displayInfo() in each subclass to show all relevant information.
open class Vehicle {
    var brand:String = ""
    var model:String = ""
    var year:Int = 0

    open fun displayInfo(){
        println("Brand: $brand")
        println("Model: $model")
        println("Year: $year")
    }
}
class Car : Vehicle() {
    var numberofDoors:Int = 0
    override fun displayInfo(){
        println("Brand: $brand")
        println("Model: $model")
        println("Year: $year")
    }
}
class Motorcycle : Vehicle() {
    var hasSidecar:Boolean = false
    override fun displayInfo(){
        println("Brand: $brand")
        println("Model: $model")
        println("Year: $year")
    }
}
fun main() {
    println("-----Car-----")
    val myCar = Car()
    myCar.brand = "BMW"
    myCar.model = "01"
    myCar.numberofDoors = 4
    myCar.year = 2020
    myCar.displayInfo()

    println()
    println("-----Motorcycle-----")
    val motorcycle = Motorcycle()
    motorcycle.brand = "Bajaj"
    motorcycle.model = "100"
    motorcycle.hasSidecar = true
    motorcycle.year = 2021
    motorcycle.displayInfo()
}
