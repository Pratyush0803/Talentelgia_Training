//fun main() {
//    val animals = listOf("Cat", "Dog", "Crow", "Cow", "Kangaroo", "Tiger","Tiger")
//    println("The length of the animal list is- " + animals.size)
//    println(animals)
//    for(animal in animals){
//        println(animal)
//    }
//    println("This is the last animal -" + animals.last())
//    val filteredAnimals = animals.filter { it.startsWith("C")}
//    println("These are the animals starting with C -$filteredAnimals")
//}

//fun main() {
//    val num = setOf(1,2 ,2,3, 4,4,5,6,7,8,9,10)
//    println(num.size)
//    println(num)
//    for (number in num){
//        print(number)
//    }
//}

//fun main() {
//    val map = mapOf(1 to "Dog", 2 to "Cat", 3 to "Cow")
//    println(map[1])
//    println(map.getOrDefault(4,"Not Found"))
//    println(map.values)
//    println(map.keys)
//    println(map.entries)
//}

//Mutable map
//fun main() {
//    val map = mutableMapOf(1 to "Dog", 2 to "Cat", 3 to "Cow")
//    map[4] = "Tiger"
//    println(map[4])
//    map.remove(4)
//    println(map)
//    println("map 4 is: " + map[4])
//}

//Mutable list
//fun main() {
//    val list = mutableListOf(1,2,3,4,5)
//    println(list)
//    list.add(6)
//    list.remove(3)
//    println(list)
//}

//Mutable set
fun main() {
    val set = mutableSetOf(1,2,3,4,5,5,4)
    println(set)
    set.add(6)
    println(set)
    set.remove(1)
    println(set)
}