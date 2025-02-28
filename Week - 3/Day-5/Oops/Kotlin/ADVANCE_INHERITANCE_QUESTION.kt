//Question 1
//Multi-Level Inheritance:
//Implement a multi-level inheritance hierarchy: Vehicle → Car → ElectricCar.
//Each class should have its own unique method and override a method from the parent class.
//
//open class Vehicle{
//    open fun model(){
//        println("The Vehicle should have a engine")
//    }
//}
//open class Car:Vehicle(){
//    override fun model() {
//        super.model()
//        println("The Car should have a method to produce energy to start the car")
//    }
//}
//class ElectricCar:Car(){
//    override fun model() {
//        super.model()
//        println("The car should be sold in low price")
//    }
//}
//fun main(){
//    val myVehicle = Vehicle()
//    val myCar = Car()
//    val myElectricCar = ElectricCar()
//
//    println("Details of the Vehicle:")
//    myVehicle.model()
//    println()
//
//    println("Details of the Car:")
//    myCar.model()
//    println()
//
//    println("Details of the Electric Car:")
//    myElectricCar.model()
//}

//---------------------------------Question 2 Modified version Question 1
//Classes:
//Vehicle: Base class with properties brand, model, and method startEngine().
//Car: Inherits from Vehicle, adds property numDoors, and overrides startEngine() with specific logic for cars.
//ElectricCar: Inherits from Car, adds property batteryCapacity and method chargeBattery(). Also overrides startEngine() to check battery level before starting.
//Requirements:
//Each class should have at least one unique method.
//Override startEngine() in each subclass, utilizing super to access parent logic.
//Demonstrate multi-level inheritance and method overriding.

//open class Vehicle(open var brand: String, open var model: String){
//    open fun startEngine(){
//        println("Starting the engine of Vehicle: $brand Model: $model")
//    }
//}
//open class Car(brand: String, model: String, var numDoors: Int):Vehicle(brand,model){
//    override fun startEngine() {
//        println("Locking the $numDoors Doors to start the car")
//        super.startEngine()
//    }
//    fun seatBelts(){
//        println("Please ensure you have using the seatbelt")
//    }
//}
//class ElectricCar(brand: String,model: String,numDoors: Int, var batteryCapacity :Int):Car(brand,model,numDoors){
//    override fun startEngine() {
//        println("Checking battery capacity...")
//        println("Battery is in $batteryCapacity%")
//        super.startEngine()
//        super.seatBelts()
//    }
//    fun start(){
//        println("The car is ready to go")
//    }
//}
//fun main(){
//    val myVehicle = Vehicle(
//        brand = "BMW",
//        model = "F8"
//    )
//    myVehicle.startEngine()
//    println()
//
//    val myCar = Car(
//        brand = "BMW",
//        model = "X8",
//        numDoors = 2
//    )
//    myCar.startEngine()
//    myCar.seatBelts()
//    println()
//
//    val myElectricCar = ElectricCar(
//        brand = "Tesla",
//        model = "S",
//        numDoors = 2,
//        batteryCapacity = 80
//    )
//    myElectricCar.startEngine()
//    myElectricCar.start()
//}
