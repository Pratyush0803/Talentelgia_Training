//-------------------------------------Question 1
//Data Validation with Encapsulation: UserAccount
//Description: Encapsulate data with validation logic.
//Class:
//UserAccount: Private properties username, password, and balance.
//Implement getter and setter methods with validation:
//Username: Must be alphanumeric.
//Password: Minimum length of 8 characters.
//Balance: Cannot be negative.
//Requirements:
//Use private properties and public methods to access and validate data.
//Demonstrate data protection and controlled access.

//class UserAccount{
//    private var username: String = ""
//    private var password: String = ""
//    private var balance: Double = 0.0
//
//    fun setUserName(username: String){
//        this.username = username
//    }
//    fun setPassword(password: String) {
//        if (password.length >= 8) {
//            this.password = password
//        }else{
//            println("Password must be 8 character")
//        }
//    }
//    fun setBalance(balance: Double){
//        if (balance >= 0){
//            this.balance = balance
//        }else{
//            println("Balance cant be negative")
//        }
//    }
//
//    fun getUserName(): String{
//        return username
//    }
//    fun getPassword(): String{
//        return password
//    }
//    fun getBalance(): Double{
//        return balance
//    }
//}
//
//fun main() {
//    val myAccount = UserAccount()
//    println("Enter your user name: ")
//    val uName = readln()
//    myAccount.setUserName(uName)
//    println("Enter your password: ")
//    val uPassword = readln()
//    myAccount.setPassword(uPassword)
//    myAccount.setBalance(140000.0)
//
//    println("Your username is: ${myAccount.getUserName()}")
//    println("Your password is: ${myAccount.getPassword()}")
//    println("Available balance is: ${myAccount.getBalance()}")
//}


// -------------------------------------Question 2
//Immutable Class: BankAccount
//Description: Create an immutable class to ensure data integrity.
//Class:
//BankAccount: Properties accountNumber and balance.
//Initialize properties via constructor and use val to prevent modification.
//Requirements:
//No setters should be provided.
//Demonstrate immutability by attempting to change the properties (which should be prohibited).

