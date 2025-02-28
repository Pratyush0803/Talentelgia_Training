
//---------------------------------------------Polymorphism - Question 1

//Create a base class Appliance with:
//A method turnOn() that prints "Turning on appliance..."
//Two subclasses:
//Fan that overrides turnOn() to print "Fan is spinning..."
//Light that overrides turnOn() to print "Light is shining..."
//Write a function that accepts a list of Appliance and calls turnOn() on each.

//open class Appliance{
//    open fun turnOn(){
//        println("Turning on appliances...")
//    }
//}
//class Fan:Appliance(){
//    override fun turnOn() {
//        println("Fan is spinning...")
//    }
//}
//class Light:Appliance(){
//    override fun turnOn() {
//        println("Light is shining...")
//    }
//}
//fun applianceList(){
//    val myAppliance = Appliance()
//    val myFan = Fan()
//    val myLight = Light()
//    myAppliance.turnOn()
//    myFan.turnOn()
//    myLight.turnOn()
//}
//fun main() {
//    applianceList()
//}

//----------------------------------------------------Question 2
//Create a class Calculator that:
//Overloads a method calculate() to handle:
//Two integers (adds them)
//Three integers (multiplies them)
//Inherits this class and overrides calculate() to handle:
//Two doubles (divides them)

//open class Calculator{
//    open fun calculate(x:Int,y:Int):Int{
//        print("$x + $y = ")
//        return x+y
//    }
//    fun calculate(x:Int,y: Int,z:Int):Int{
//        print("$x x $y x $z = ")
//        return x*y*z
//    }
//}
//class DCalculator:Calculator(){
//    fun calculate(x:Double,y:Double):Double{
//        print("$x / $y = ")
//        return x/y
//    }
//}
//
//fun main() {
//    val myCalculator = DCalculator()
//    println(myCalculator.calculate(13,45))
//    println(myCalculator.calculate(13,45,55))
//    println(myCalculator.calculate(10.0,5.0))
//}

//---------------------------------Question 3
//Create a base class Animal with a method sound() and a subclass Cat that overrides sound().
//Store a Cat object as an Animal reference (upcasting).
//Call sound() and observe the output.
//Downcast the reference back to Cat and call sound() again.
open class Animal {
    open fun sound(){
        println("Random animal sound...")
    }
}
class Cat:Animal(){
    override fun sound(){
        println("Meow,meow....")
    }
}

fun main() {
    val mySound: Animal = Cat()
    mySound.sound()

    val myCat = mySound as Cat
    myCat.sound()
}