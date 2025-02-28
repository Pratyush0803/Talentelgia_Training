//---------------------------------------------Question 1
//Create an abstract class Animal with an abstract method sound().
//Create two subclasses, Dog and Cat, that provide their own implementation of the sound() method.
//Instantiate the subclasses and call the sound() method.

//abstract class MyAnimal{
//    abstract fun sound()
//}
//class Lion:MyAnimal(){
//    override fun sound() {
//        println("The lion says : Roar...Roar...")
//    }
//}
//class Wolf:MyAnimal(){
//    override fun sound() {
//        println("The Wolf says: Awoo...Awoo...")
//    }
//}
//
//fun main() {
//    val animal = Wolf()
//    animal.sound()
//
//    val animal2 = Lion()
//    animal2.sound()
//}

//Question 2
//Design an abstract class Shape with an abstract method area().
// Create two subclasses, Circle and Rectangle, to calculate and return the area for each shape.

//abstract class Shape(){
//    abstract fun area()
//}
//class Circle(private var r:Double):Shape(){
//    override fun area() {
//        val result = 3.14 * r *r
//        println("The area of Circle is : $result")
//    }
//}
//class Rectangle(private var h:Int, private var w:Int):Shape(){
//    override fun area() {
//        val result = h * w
//        println("The area of Rectangle is : $result")
//    }
//}
//fun main(){
//    val myCircle = Circle(17.86)
//    myCircle.area()
//
//    val myRectangle = Rectangle(10,20)
//    myRectangle.area()
//}

//-----------------------------------------Question 3
