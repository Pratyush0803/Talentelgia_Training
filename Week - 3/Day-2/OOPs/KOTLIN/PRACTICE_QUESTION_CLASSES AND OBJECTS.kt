//--------------------------------------------Question 1
//Create a class Counter that:
//
//Starts at 0
//Increments by 1 with a method increment()
//Returns the current value with a method getValue()

//class Counter{
//    private var x = 0
//    fun increment(){
//         x++
//    }
//    fun getValue(): Int {
//        val value = x
//        return x
//    }
//}
//fun main(){
//    val myCounter = Counter()
//    println(myCounter.getValue())
//    println(myCounter.increment())
//    println(myCounter.getValue())
//    println(myCounter.increment())
//    println(myCounter.getValue())
//}

//----------------------------------------------Question 2
//Create an object MathUtils that has:
//A method square(n: Int) that returns the square of a number
//A method cube(n: Int) that returns the cube of a number

//class Calculation{
//    var n = 0
//    fun square(n:Int):Int{
//        return n*n
//    }
//    fun cube(n:Int):Int{
//        return n*n*n
//    }
//}
//fun main(){
//    val mycalculation = Calculation()
//
//    println(mycalculation.square(13))
//    println(mycalculation.cube(3))
//}

//---------------------------------------------Question 3
//Create a class User with:
//A private constructor
//A companion object with a method createUser(name: String) to create an instance of User

//class User private constructor(val name:String){
//    companion object{
//        fun createUser(name: String):User{
//            return User(name)
//        }
//    }
//}
//fun main() {
//    val user = User.createUser("Pratyush")
//    println(user.name)
//}
