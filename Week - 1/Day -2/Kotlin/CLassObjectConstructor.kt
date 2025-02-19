//class Details{
//    var name = ""
//    var age = 0
//    var gender = ""
//}
//fun main(){
//    val obj = Details()
//    obj.name= "Bubu"
//    obj.age = 21
//    obj.gender = "Male"
//    println(obj.name)
//    println(obj.age)
//    println(obj.gender)
//}
class Constructor(val name: String, val age: Int, val gender: String)

fun main() {
    val obj = Constructor("Bubu", 21, "Male")
    println(obj.name)
    println(obj.age)
    println(obj.gender)
}