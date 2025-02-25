import kotlin.math.sqrt

//class Addition{
//    fun add(num1:Int,num2:Int):Int{
//        return num1+num2
//    }
//}
//fun main(){
//    val myAdd = Addition()
//    println(myAdd.add(1,17))
//}

//Question
//    fun myAdd():Int{
//        var sum = 0
//        for (i in arrayOf(1,2,3,4,5)){
//            sum += i
//        }
//    return sum
//    }
//fun main(){
//    println(myAdd())
//}
//fun myAdd(myArray:IntArray):Int{
//    var sum = 0
//    for (i in myArray.indices){
//        sum += myArray[i]
//    }
//    return sum
//}
//fun main(){
//    println(myAdd(50))
//}
//-------------------------------Standard Library----------------------
//fun main() {
//    println("Enter a number to find its Square Root")
//    var num = readln().toDouble()
//    var result = sqrt(num.toDouble())
//    println("Square root of $num : $result")
//}
//---------------------------------------------Recursion----------------------------------------------

var count = 0
fun rec(){
    count++
    if(count<=5){
        println("Hi everyone $count")
        rec()
    }
}
fun main() {
    rec()
}