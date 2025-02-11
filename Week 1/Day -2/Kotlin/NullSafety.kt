//fun main(){
//    var x:String = "Bubu"
//    var y:String? = null
//
//    println(x)
//    println(y)
//    println(x.length)
////    println(y!!.length)  Use !! it if you know your var is not null
//    y = "Gugu"
//    println("Hello $y your name length is ${y.length}")
//}

//fun main() {
//    var x :String? = "Bubu"
//    if (x != null){
//        print(x.toUpperCase())
//        println(" -- The Length Of Name Is:"+x.length)
//    }else{
//        println("x is null")
//    }
//}

//fun main() {
//    var y :String? = null
//    if (y != null){
//        print(y.toUpperCase())
//        println(" -- The Length Of Name Is:"+y.length)
//    }else{
//        println("y is null")
//    }
//}

// This expression - ?.  is equal to:
// if(firstName != null)
//    firstName.toUpperCase()
//else
//    null
//fun main() {
//    val y :String? = null
//    println(y?.length)
//}

//fun main() {
//    val y :String? = "Animal"
//    println(y?.length)
//    println(y?.toUpperCase())
//}

// We can use the safe call operator with let(), also() and run() if value is not null:
fun main() {
    val x:String = "Bubu"
    x.let {
        println(it.toUpperCase())
    }
}