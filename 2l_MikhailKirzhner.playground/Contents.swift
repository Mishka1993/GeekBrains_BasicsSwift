import Cocoa

//Задание №1
//Написать функцию, которая определяет, четное число или нет

func functionTask1 (i: Int) {
    if(i % 2) == 0 {
        print("\(i) Число четное")
    }
    else{
        print("\(i) Число нечетное")
    }
}
functionTask1(i: 5)
//Задание %2
//Написать функцию, которая определит делится ли число без остатка на 3

func functionTask2 (i: Int){
    if(i % 3) == 0 {
        print("\(i) Делится на 3")
    }
    else{
        print("\(i) Не делится на 3")
    }
}
functionTask2(i: 6)
//Задание №3
//Создать возврастающий массив из 100 чисел

var array = [Int]()

for i in 0 ... 99 {
    array.append(i)
}
//Задание №4
//Удалить из этого массива все четные числа и все числа, которые не делятся на 3
var i = 0
while i < array.count{
    if (i%2 == 0) || (i%3 == 0){
        array.remove(at : (array.firstIndex(of: i)!))
    }
    i += 1
}
//Задание №5
//Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов
func functionTask5 (n: UInt, FirstArg: UInt, SecondArg: UInt) -> [UInt]{
    var array: [UInt] = [FirstArg, SecondArg]
    if (FirstArg < SecondArg){
        for i in 2 ... n {
            array.append(array[Int(i) - 1] + array[Int(i) - 2])
        }
    }
    return array
}

functionTask5(n: 50, FirstArg: 1, SecondArg: 2)
//Задание №6
//Заполнить массив элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n (пусть будет 100).

func functionTask6(_ array: inout [Int]){
    for i in 0 ... 1000 {
        if(Prime(i) == true){
            array.append(i)
        }
    }
}
func Prime(_ n : Int) -> Bool{
    var b = true
    if n <= 1 {
        return false
    } else {
        for y in 2...n {
            if y == n {
                b = true
                break
            } else if n % y == 0 {
                b = false
                break
            }
        }
    }
    return b
}

var Array6 = [Int]()
functionTask6(&Array6)

while (Array6.count > 100){
    Array6.removeLast()
}
