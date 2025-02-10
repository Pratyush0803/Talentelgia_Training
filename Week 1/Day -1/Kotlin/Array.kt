fun main() {
    //Using arrayOf()
    val x = arrayOf("Bubu",8,"Gugu")
    println(x[2])

    //Using Array<>
    val a:Array<Int> = arrayOf(1,2,3,4,5,6,6,7,)
    println(a[4])
    println(a[3])
    println(a[5])

    //Using IntArray,StringArray...
    val b:IntArray = intArrayOf(1,2,3,4,4)
    println(b[1])
    println(b[2])
    println(b[3])
}