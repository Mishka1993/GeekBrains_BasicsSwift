import Cocoa
import Foundation


//Задача №1
let a: Double = 1
let b: Double = -5
let c: Double = 6

let D: Double = pow(b, 2) - (4 * a * c)
let x1: Double
let x2: Double

if (D > 0) {
    x1 = (-b + sqrt(D))/2 * a
    x2 = (-b - sqrt(D))/2 * a
    print(x1, x2)
}
else if(D == 0) {
    x1 = -b/(2 * a)
    print(x1)
}
else {
    RETURN
}


//Задача №2
let side1: Double = 10
let side2: Double = 20
let side3: Double = sqrt(pow (side1, 2) + pow(side2, 2))

let S: Double = 0.5 * side1 * side2
print(S)
let P: Double = side1 + side2
print(P)


//Задача №3
var sum: Double = 1000
let percent: Double = 6
let periodM: Int = 60
var result: Double = sum

for _ in 1 ... periodM {
    result += result * (percent/100/12)
}
print(result)
