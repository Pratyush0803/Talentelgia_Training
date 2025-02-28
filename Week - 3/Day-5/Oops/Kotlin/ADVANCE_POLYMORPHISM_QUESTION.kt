//---------------------------------Question 1
// Runtime Polymorphism with Interface: Payment System
//Description: Implement runtime polymorphism with interfaces.
//Interfaces and Classes:
//PaymentMethod: Interface with method pay(amount: Double).
//CreditCardPayment: Implements PaymentMethod, processes credit card payments.
//UPIPayment: Implements PaymentMethod, processes UPI payments.
//NetBankingPayment: Implements PaymentMethod, processes net banking payments.
//Requirements:
//Store objects in a List<PaymentMethod> and iterate using a loop to call pay() dynamically.
//Demonstrate runtime polymorphism and dynamic method binding.

//interface PaymentMethod{
//    fun pay(amount: Double)
//}
//class CreditCardPayment:PaymentMethod{
//    override fun pay(amount: Double) {
//        println("The amount of $amount₹ is credited from your account")
//    }
//}
//class UPIPayment:PaymentMethod{
//    override fun pay(amount: Double) {
//        println("You received amount of $amount₹ to your UPI account")
//    }
//}
//class NetBankingPayment:PaymentMethod{
//    override fun pay(amount: Double) {
//        println("Amount of $amount is credited from your account for activating Net Banking")
//    }
//}
//
//fun main() {
//    val paymentMethod: List<PaymentMethod> = listOf(
//        CreditCardPayment(),
//        UPIPayment(),
//        NetBankingPayment()
//    )
//    for (method in paymentMethod){
//        method.pay(100.0)
//    }
//}

//-------------------------------------Question 2
//Description: Use polymorphic function parameters for inventory management.
//Interfaces and Classes:
//Item: Interface with method getPrice().
//Electronics: Implements Item, adds warranty property.
//Groceries: Implements Item, adds expiryDate property.
//Clothing: Implements Item, adds size and material properties.
//Requirements:
//Implement a function calculateTotal(items: List<Item>) that uses polymorphism to calculate the total price.
//Pass different subclass objects to observe polymorphic behavior.

interface Item{
    fun getPrice(): Double
}
class Electronics(private var price: Double,private var warranty: Int):Item{
    override fun getPrice(): Double {
        return price
    }
    fun getWarranty(): Int{
        return warranty
    }
}
class Groceries(private var price: Double,private var expiryDate: Int):Item{
    override fun getPrice(): Double {
        return price
    }
    fun getExpiryDate():Int{
        return expiryDate
    }
}
class Clothing(private var price: Double, private var material: String, private var size: Char):Item{
    override fun getPrice(): Double {
        return price
    }
    fun getSize(): Char{
        return size.toChar()
    }
    fun getMaterial(): String{
        return material
    }
}
fun calculateTotal(items: List<Item>): Double{
    var total = 0.0
    for (item in items){
        total += item.getPrice()
    }
    return total
}
fun main() {
    val items: List<Item> = listOf(
        Electronics(
            price = 99.0,
            warranty = 12
        ),
        Groceries(
            price = 12.2,
            expiryDate = 2),
        Clothing(
            price = 300.0,
            material = "Cotton",
            size = 'M'
        )
    )
    val totalPrice = calculateTotal(items)
    println("Total Price: $totalPrice")
}