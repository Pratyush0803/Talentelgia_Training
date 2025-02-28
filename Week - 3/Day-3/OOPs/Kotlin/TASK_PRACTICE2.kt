//class Calculator{
//    fun addition(x:Number, y:Number):Number{
//        return x+y
//    }
////    fun addition(x:String, y:String): String {
////        return x+y
////    }fun addition(x:Float, y:Float): Float {
////        return x+y
////    }
//}
//
//fun main() {
//    val myCalculator = Calculator()
//    println(myCalculator.addition(1,2))
////    println(myCalculator.addition("Pratyush ","Jena"))
//    println(myCalculator.addition(1.3f,4.5f))
//}

//---------------------------------------------Question 1
/* Create a class Area and a method displayArea.
Override every method to calculate
         --Area of Rectangle, h and w
         --Area of Square a, a*a
         --Area of Circle r, 3.14*r*r
 */

//open class Area {
//    open fun displayArea() {}
//}
//class MyRectangle(private val h:Int, private val w:Int) : Area(){
//    override fun displayArea() {
//        val result = h * w
//        println("The area of Rectangle : $result")
//    }
//}
//class MySquare(private val a:Int) : Area(){
//    override fun displayArea(){
//        val result = a * a
//        println("The area of Square :$result")
//    }
//}
//class MyCircle(private val r:Double) : Area(){
//    override fun displayArea() {
//        val result = 3.14 * r * r
//        println("The area of circle is : $result")
//    }
//}
//
//fun main() {
//    val rectangle = MyRectangle(10,20)
//    rectangle.displayArea()
//
//    val square = MySquare(3)
//    square.displayArea()
//
//    val circle = MyCircle(12.33)
//    circle.displayArea()
//}

//--------------------------------------------------Question 2
//Create a fun to add generic type
//class Addition<T : Number>(private val x: T, private val y: T) {
//    fun add() {
//        when(x){
//            is Byte -> {
//                println(x.toByte()+y.toByte())
//            }is Short -> {
//                println(x.toShort()+y.toShort())
//            }is Int -> {
//                println(x.toInt()+y.toInt())
//            }is Long -> {
//                println(x.toLong()+y.toLong())
//            }is Float -> {
//                println(x.toFloat()+y.toFloat())
//            }is Double -> {
//                println(x.toDouble()+y.toDouble())
//            }
//        }
//    }
//}
//
//fun main() {
//    val addition = Addition(1, 3699999999999999999)
//    addition.add()
//}

//Question 3
//Create a function to add multiple arguments and sum it to print the value using generic type
