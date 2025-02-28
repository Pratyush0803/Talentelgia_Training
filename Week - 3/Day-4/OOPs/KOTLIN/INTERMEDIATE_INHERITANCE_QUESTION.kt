//--------------------------------Question 1
//Create a base class Person with properties name and age.
//Derive Student and Teacher classes with additional properties (rollNumber for Student and subject for Teacher).
//Override a method displayDetails() in both subclasses.
//
//open class Person{
//    var name:String = ""
//    var age :Int = 0
//
//    open fun displayDetails(){
//    }
//}
//class Student(val rollNumber:Int, val marks:Int):Person(){
//    override fun displayDetails() {
//        println("_________Teacher Details_________")
//        println(" Name: $name\n Age: $age\n Roll no: $rollNumber\n Marks: $marks")
//    }
//}
//class Teacher(val subject:String):Person(){
//    override fun displayDetails() {
//        println("_________Student Details_________")
//        println(" Name: $name\n Age: $age\n Subject: $subject")
//    }
//}
//fun main(){
//    val student = Student(21,100)
//    student.name = "Pratyush Kumar Jena"
//    student.age = 21
//    student.displayDetails()
//
//    val teacher = Teacher("Kotlin")
//    teacher.name = "Ravi Shankar Kumar"
//    teacher.age = 35
//    teacher.displayDetails()
//}

//---------------------------------------EXTRA
//open class Person(var name: String="", var age: Int=0) {
//
//    open fun displayDetails(){
//    }
//}
//class Student(private val rollNumber:Int, private val marks:Int, studentAge:Int, studentName:String):Person(studentName,studentAge){
//    override fun displayDetails() {
//        println("_________Teacher Details_________")
//        println(" Name: ${super.name}\n Age: ${super.age}\n Roll no: $rollNumber\n Marks: $marks")
//    }
//}
//class Teacher(val subject:String,val a:Int,val n:String):Person() {
//
//    override fun displayDetails() {
//        super.age=a
//        super.name=n
//        println("_________Student Details_________")
//        println(" Name: $name\n Age: $age\n Subject: $subject")
//    }
//}
//fun main(){
//    val student = Student(21,100,20,"Pratyush ")
////    student.name = "Pratyush Kumar Jena"
////    student.age = 21
//    student.displayDetails()
//
//    val teacher = Teacher("Kotlin",21,"Ravi Shankar Kumar")
////    teacher.name = "Ravi Shankar Kumar"
////    teacher.age = 35
//    teacher.displayDetails()
//}
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------Question 2
//