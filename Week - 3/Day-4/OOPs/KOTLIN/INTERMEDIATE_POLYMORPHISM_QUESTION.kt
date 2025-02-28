//--------------------------------------------Question 1
// Create a function printPaymentDetails(payment: Payment) where Payment is a base class.
//Subclass CreditCardPayment and PaypalPayment, each overriding makePayment() method.
//Demonstrate polymorphism by passing different subclass objects to the function.

//open class Payment{
//    open fun makePayment(){
//        println("Making a Payment")
//    }
//}
//class CreditCardPayment:Payment(){
//    override fun makePayment(){
//        println("Making Credit Card Payment...")
//    }
//}
//class PayPalPayment:Payment(){
//    override fun makePayment() {
//        println("Making PayPal Payment...")
//    }
//}
//fun printPaymentDetails(payment: Payment){
//    payment.makePayment()
//}
//fun main() {
//    val ccPayment = CreditCardPayment()
//    val ppPayment = PayPalPayment()
//
//    printPaymentDetails(ccPayment)
//    printPaymentDetails(ppPayment)
//}

//---------------------------------------Question 2
//Design an interface Drawable with a method draw().
//Implement the interface in Circle and Square.
//Use polymorphism to call draw() on a list of Drawable objects.

//interface Drawable{
//    fun draw()
//}
//class Circle:Drawable{
//    override fun draw() {
//        println("Drawing Circle is started...")
//    }
//}
//class Square:Drawable{
//    override fun draw() {
//        println("Drawing Square is Started...")
//    }
//}
//fun main(){
//    val myCircle = Circle()
//    val mySquare = Square()
//
//    myCircle.draw()
//    mySquare.draw()
//}