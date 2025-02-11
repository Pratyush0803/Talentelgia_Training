////fun main(args: Array<String>){
////    val data = 20 / 0
////    println(data)
////}
//fun main() {
//    val data = try {
//        20 / 0
//    } catch (e: Exception) {
//        println("Divided by zero is not allowed")
//    }
//}

//fun test(a: Int, b:Int): Any{
//    return try {
//        a / b
//    }
//    catch (e:Exception){
//        println(e)
//        println("Divided by zero is not allowed")
//    }
//}
//fun main() {
//    var res1 = test(10,0)
//    println(res1)
//    var res2 = test(10,5)
//    println(res2)
//}
//fun main() {
//    try {
//        val ar = arrayOf(1,2,3)
//        val x = ar[3]
//        println(x)
//    }finally {
//        println("Finally block is always executed")
//    }
//}

//fun main() {
//    try {
//        var int = 10 / 0
//        println(int)
//    }catch (e :ArithmeticException){
//        println(e)
//    }finally {
//        println("Finally block is always executed")
//    }
//}


fun pass(password:String) {
    if (password.length<6){
        throw ArithmeticException("Password is too short!")
    }else
    {
        println("Welcome!")
    }
}
fun main() {
    println("Enter your password")
    val password = readLine()
    pass(password!!)
}