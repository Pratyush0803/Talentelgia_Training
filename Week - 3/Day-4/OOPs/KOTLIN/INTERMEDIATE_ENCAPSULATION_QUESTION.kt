//-------------------------------------Question 1
//Create a class Student with private properties name, rollNumber, and grade.
//Provide public getter and setter methods for all properties.
//In the setter for grade, ensure the value is between A and F.

//class Student{
//    private var name:String = ""
//    private var rollNumber = 0
//    private var grade:String = " "
//
//    fun setName(name:String){
//        this.name = name
//    }
//    fun setRollNumber(rollNumber:Int){
//        this.rollNumber = rollNumber
//    }
//    fun setGrade(grade:String){
//        if (grade in "A".."F"){
//            this.grade = grade
//        }else {
//            println("Enter a valid grade from A-F")
//        }
//    }
//    fun getName():String{
//        return name
//    }
//    fun getRollNumber():Int{
//        return rollNumber
//    }
//    fun getGrade():String{
//        return grade
//    }
//}
//fun main(){
//    val myStudent = Student()
//    myStudent.setName("Pratyush  Kumar Jena")
//    myStudent.setRollNumber(21)
//    myStudent.setGrade("G")
//
//    println("Name: ${myStudent.getName()}")
//    println("Roll no: ${myStudent.getRollNumber()}")
//    println("Grade: ${myStudent.getGrade()}")
//}

//-------------------------------------------Question
//Design a class Book with private properties title, author, and price.
//Use public methods to set and get each property.
//Ensure the price cannot be negative.

//class Book{
//    private var tittle:String = ""
//    private var author:String = ""
//    private var price:Int = 0
//
//    fun setTittle(tittle:String){
//        this.tittle = tittle
//    }
//    fun setAuthor(author:String){
//        this.author = author
//    }
//    fun setPrice(price:Int){
//        if (price >0){
//            this.price = price
//        }
//    }
//
//    fun getTittle():String{
//        return tittle
//    }
//    fun getAuthor():String{
//        return author
//    }
//    fun getPrice():Int{
//        return price
//    }
//}
//fun main(){
//    val myBook = Book()
//    myBook.setTittle("Waste Land")
//    myBook.setAuthor("T.S Eliot")
//    myBook.setPrice(500)
//
//    println("Tittle: ${myBook.getTittle()}")
//    println("Author: ${myBook.getAuthor()}")
//    println("Price: ${myBook.getPrice()}$")
//}