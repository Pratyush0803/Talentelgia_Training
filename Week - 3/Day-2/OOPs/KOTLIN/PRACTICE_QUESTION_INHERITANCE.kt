//------------------------------------------------------Inheritance- Question 1
//Create a base class Animal with:
//A method makeSound() that prints "Some sound..."
//A subclass Dog that overrides makeSound() to print "Bark!"

//open class Animal{
//    open fun makeSound(){
//        println("Some sound...")
//    }
//}
//class Dog : Animal(){
//    override fun makeSound(){
//        println("Bark!")
//    }
//}
//
//fun main() {
//    val myAnimal = Dog()
//    myAnimal.makeSound()
//}

//--------------------------------------------------Question 2
//Create a base class Vehicle with:
//A method start() that prints "Vehicle starting..."
//A subclass Car that overrides start() but also calls the start() method of Vehicle before printing "Car ready to go!"

//open class MyVehicle{
//    open fun start(){
//        println("Vehicle starting...")
//    }
//}
//class MyCar: MyVehicle(){
//    override fun start(){
//        super.start()
//        println("Car ready to go")
//    }
//}
//
//fun main() {
//    val car = MyCar()
//    car.start()
//}

//---------------------------------------------------Question 3
//Create a base class Person with a primary constructor that accepts a name and age.
//Create a subclass Student that adds a grade property and prints all details.

//open class Person(name:String,age:Int){
//    init {
//        println("Name: $name and Age: $age")
//    }
//}
//class Student(name: String,age: Int,grade: Int): Person(name,age){
//    init {
//        println("Grade : $grade")
//    }
//}
//
//fun main() {
//    val student = Student("Pratyush",21,5)
//}