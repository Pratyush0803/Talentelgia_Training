
//    for (a in 1..5){
//        for (b in 1..a){
//            a+1
//            print(" " +b + " ")
//        }
//        println()
//    }
//fun main() {
//    for (i in 1..5){
//        for (j in 1..i){
//            print(" * ")
//        }
//        println()
//    }
//}

fun main() {
    for(i in 1..5){
        for (k in 1..5-i){
            print("  ")
        }
        for (j in 1..i){
            i+1
            print("  $i ")
        }
        println()
    }
}