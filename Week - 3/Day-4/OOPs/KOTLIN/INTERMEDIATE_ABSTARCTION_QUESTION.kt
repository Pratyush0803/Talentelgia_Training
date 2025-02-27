//---------------------------------------Question 1
//Design an abstract class PaymentGateway with an abstract method processPayment().
//Subclass CreditCard and NetBanking, each implementing its own payment logic.

//abstract class PaymentGateway{
//    abstract fun processPayment()
//}
//class CreditCard: PaymentGateway() {
//    override fun processPayment() {
//        println("Amount of 200$ is debited from your account")
//    }
//}
//class NetBanking:PaymentGateway(){
//    override fun processPayment() {
//        println("Your Net Banking Services has Activated")
//    }
//}
//fun main(){
//    val cc = CreditCard()
//    val nb = NetBanking()
//
//    cc.processPayment()
//    nb.processPayment()
//}

//------------------------------------Question 2
//Create an abstract class Device with an abstract method start().
//Implement subclasses Smartphone and Laptop, each overriding start() with their own logic.

abstract class Device{
    abstract fun start()
}
class SmartPhone:Device(){
    override fun start() {
        println("Your Smart Phone is opening...")
    }
}
class Laptop:Device(){
    override fun start() {
        println("Your pc is opening...")
    }
}
fun main(){
    val mySmartPhone = SmartPhone()
    val myLaptop = Laptop()

    mySmartPhone.start()
    myLaptop.start()
}