//----------------------------------Pattern1:
//*
//*  *
//*  *  *
// *  *  *  *
// *  *  *  *  *

// fun main() {
//    for (i in 1..5){
//        for(j in 1..i){
//            print(" * ")
//        }
//        println()
//    }
//}


//--------------------------------------------Pattern 2:
//           *
//         *   *
//       *   *   *
//      *   *   *   *
//    *   *   *   *   *

//fun main() {
//    for (i in 1..5){
//        for (k in 1..5-i){
//            print("  ")
//        }
//        for (j in 1..i){
//            print(" *  ")
//        }
//        println()
//    }
//}


//---------------------------------Pattern 3:
//1
//1 2
//1 2 3
//1 2 3 4
//1 2 3 4 5

//fun main(){
//    for (i in 1..5){
//        for(j in 1..i){
//            print(" $j ")
//        }
//        println()
//    }
//    Using input
//    println("Enter your number to print pattern: ")
//    var n = readln().toInt()
//    for (row in 1..n){
//        for (col in 1..row){
//            print(" $col ")
//        }
//        println()
//    }
//}

//-----------------------------Pattern 4:
//         1
//        1 2
//      1  2  3

//fun main() {
//    for (row in 1..5){
//        for (space in 1..5-row){
//            print("  ")
//        }
//        for (col in 1..row){
//            print(" $col  ")
//        }
//        println()
//    }
//}
//Using input
//fun main() {
//    println("Enter your number to print pattern")
//    var n = readln().toInt()
//
//    for (row in 1..n){
//        for (spaces in 1..n-row){
//            print("  ")
//        }
//        for (col in 1..row){
//            print(" $col  ")
//        }
//        println()
//    }
//}


//-----------------------------------Pattern 5:
//a
//a  b
//a  b  c
// a  b  c  d

//fun main() {
//    for (row in 1..5){
//        var char = 'a'
//        for (col in 1..row){
//            print(" $char ")
//            char++
//        }
//        println()
//    }
//}
//Using input
//fun main() {
//    println("Enter the number of rows you want print: ")
//    val n = readln().toInt()
//    for (row in 1..n){
//        var char = 'a'
//        for (col in 1..row){
//            print(" $char ")
//            char++
//        }
//        println()
//    }
//}

//--------------------------------Pattern 6:
//     a
//    a  b
//   a  b  c
//  a  b  c  d
//fun main() {
//    for (row in 1..5){
//        var char = 'a'
//        for (spaces in 1..5-row){
//            print("  ")
//        }
//        for (col in 1..row) {
//            print(" $char  ")
//            char++
//        }
//        println()
//    }
//}
//Using input
fun main() {
    println("Enter the number of rows you want to print")
    val n = readln().toInt()

    for (row in 1..n){
        var char = 'a'
        for (spaces in 1..n-row){
            print("  ")
        }
        for (col in 1..row){
            print(" $char  ")
            char++
        }
        println()
    }
}