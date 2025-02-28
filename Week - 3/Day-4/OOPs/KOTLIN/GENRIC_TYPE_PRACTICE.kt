//class AnyType<T>(var type:T)
//fun main() {
//    val age = AnyType(21)
//    val name = AnyType("Pratyush Kumar Jena")
//    val grade = AnyType('A')
//    val cgpa = AnyType(8.9)
//
//    println("Name: ${name.type}")
//    println("Age: ${age.type}")
//    println("CGPA: ${cgpa.type}")
//    println("Grade: ${grade.type}")
//}


fun <T> swap(a: T, b: T) {
    var first = a
    var second = b
    println("Before Swap: first = $first, second = $second")

    val temp = first
    first = second
    second = temp

    println("After Swap: first = $first, second = $second")
}

fun main() {
    swap(10, 20)
    swap("Hello", "World")
}
