<<<<<<< HEAD
import Cocoa

=======
/*
1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
6. Вывести значения свойств экземпляров в консоль.

*/
import Cocoa
import Foundation

enum engineRunning{
    case on
    case off
}
enum openWindows{
    case open
    case close
}
enum filledTrunk{
    case full
    case half
    case empty
}

struct SportCar {
    var mark: String
    var release: Int
    var trunkState : filledTrunk = .empty
    var freeSpaceTrunk: Int = 0
    var emptyTrunk: Int

    init(mark: String, release: Int, trunkVolume: Int){
        self.mark = mark
        self.release = release
        self.trunkVolume = trunkVolume
        self.emptyTrunk = self.trunkVolume
    }

    var engineState: engineRunning = .off{
        willSet{
            if newValue == .on {
                print ("У \(mark) двигатель запущен")
            } else {
                print("У \(mark) двигатель остановлен")
            }
        }
    }

    var windowsState: openWindows = .close{
        willSet{
            if newValue == .open {
                print ("\(mark) окна открыты")
            } else {
                print("\(mark) окна закрыты")
            }
        }
    }


    var trunkVolume: Int{
        willSet{
            if trunkState == .empty && trunkVolume >= 0 && newValue < trunkVolume {
                self.freeSpaceTrunk = self.trunkVolume - newValue
                print ("В \(mark) загружено \(newValue), свободного места: \(freeSpaceTrunk)л")
                if(freeSpaceTrunk == 0){
                    print ("В \(mark) багажник полностью заполненный")
                }
            }else if trunkState == .half && trunkVolume != 0 {
                if newValue > 0 {
                    freeSpaceTrunk = freeSpaceTrunk - newValue
                    print ("В \(mark) загружено \(newValue), свободного места: \(freeSpaceTrunk)л")
                    if(freeSpaceTrunk == 0){
                        print ("В \(mark) багажник полностью заполненный")
                    }
                }else if newValue < 0{
                    freeSpaceTrunk = freeSpaceTrunk - newValue
                    print ("Из \(mark) выгружено \(newValue), свободного места: \(freeSpaceTrunk)л")
                }
            } else if newValue > freeSpaceTrunk {
                    print("В \(mark) \(newValue)л столько не влезет, свободного места: \(freeSpaceTrunk)л")
            }



            if freeSpaceTrunk == self.emptyTrunk {
                trunkState = .empty
            }else if freeSpaceTrunk == 0{
                trunkState = .full
            }else if freeSpaceTrunk > 0 && freeSpaceTrunk < self.emptyTrunk{
                trunkState = .half
            }
        }
    }
    
    // Функция выгружает все из багажника авто
    mutating func emptyTrunck() {
        self.trunkState = .empty
        trunkVolume = emptyTrunk
        freeSpaceTrunk = 0
        print ("У автомобиле марки \(mark) все выгружено из багажника, объем багажника составляет \(trunkVolume)")
    }
    
    // Функция проводит диагностику двигателя если он не заветься с 3 раз, двигатель неисправен
    mutating func diagnosticsEngine(){
        if engineState != .off {
            self.engineState = .off
        }
        
        for i in 1 ... 3{
            let randomValue = Int.random(in: 1..<10)
            if randomValue <= 5 {
                self.engineState = .on
                print("\(mark) завелась с \(i) раза")
                break
            }else if i == 3 {
                print("У \(mark) двигатель не завелся, требудется ремонт")
            }
        }
        
    }
}

struct TrunkCar {
    var mark: String
    var release: Int
    var trunkState : filledTrunk = .empty
    var freeSpaceTrunk: Int = 0
    var emptyTrunk: Int

    init(mark: String, release: Int, trunkVolume: Int){
        self.mark = mark
        self.release = release
        self.trunkVolume = trunkVolume
        self.emptyTrunk = self.trunkVolume
    }

    var engineState: engineRunning = .off{
        willSet{
            if newValue == .on {
                print ("У \(mark) двигатель запущен")
            } else {
                print("У \(mark) двигатель остановлен")
            }
        }
    }

    var windowsState: openWindows = .close{
        willSet{
            if newValue == .open {
                print ("\(mark) окна открыты")
            } else {
                print("\(mark) окна закрыты")
            }
        }
    }


    var trunkVolume: Int{
        willSet{
            if trunkState == .empty && trunkVolume >= 0 && newValue < trunkVolume {
                self.freeSpaceTrunk = self.trunkVolume - newValue
                print ("В \(mark) загружено \(newValue), свободного места: \(freeSpaceTrunk)л")
                if(freeSpaceTrunk == 0){
                    print ("В \(mark) багажник полностью заполненный")
                }
            }else if trunkState == .half && trunkVolume != 0 {
                if newValue > 0 {
                    freeSpaceTrunk = freeSpaceTrunk - newValue
                    print ("В \(mark) загружено \(newValue), свободного места: \(freeSpaceTrunk)л")
                    if(freeSpaceTrunk == 0){
                        print ("В \(mark) багажник полностью заполненный")
                    }
                }else if newValue < 0{
                    freeSpaceTrunk = freeSpaceTrunk - newValue
                    print ("Из \(mark) выгружено \(newValue), свободного места: \(freeSpaceTrunk)л")
                }
            } else if newValue > freeSpaceTrunk {
                    print("В \(mark) \(newValue)л столько не влезет, свободного места: \(freeSpaceTrunk)л")
            }



            if freeSpaceTrunk == self.emptyTrunk {
                trunkState = .empty
            }else if freeSpaceTrunk == 0{
                trunkState = .full
            }else if freeSpaceTrunk > 0 && freeSpaceTrunk < self.emptyTrunk{
                trunkState = .half
            }
        }
    }
    
    // Функция выгружает все из багажника авто
    mutating func emptyTrunck() {
        self.trunkState = .empty
        trunkVolume = emptyTrunk
        freeSpaceTrunk = 0
        print ("У автомобиле марки \(mark) все выгружено из багажника, объем багажника составляет \(trunkVolume)")
    }
    
    // Функция проводит диагностику двигателя если он не заветься с 3 раз, двигатель неисправен, у грузовика увиличил значение рандома тк у них обычно двигатели более изношены
    mutating func diagnosticsEngine(){
        if engineState != .off{
            self.engineState = .off
        }
        
        for i in 1 ... 3{
            let randomValue = Int.random(in: 1..<20)
            if randomValue <= 5 {
                self.engineState = .on
                print("\(mark) завелась с \(i) раза")
                break
            }else if(i == 3){
                print("У \(mark) двигатель не завелся, требудется ремонт")
            }
        }
    }
}

var Honda = SportCar(mark: "Honda", release: 2016, trunkVolume: 320)
var Toyota = SportCar(mark: "Toyota", release: 2021, trunkVolume: 380)

var Volvo = TrunkCar(mark: "Volvo", release: 2000, trunkVolume: 12000)
var Scania = TrunkCar(mark: "Scania", release: 2009, trunkVolume: 11300)

Honda.engineState = .off
Honda.trunkVolume = 120
Honda.trunkVolume = -80
Honda.trunkVolume = 60
Honda.diagnosticsEngine()
Honda.emptyTrunck()

Toyota.windowsState = .open
Toyota.trunkVolume = 200
Toyota.trunkVolume = -50
Toyota.diagnosticsEngine()
Toyota.engineState = .off
print(Toyota.release)

Volvo.engineState = .on
Volvo.trunkVolume = 5500
Volvo.trunkVolume = -2000
Volvo.trunkVolume = 1100
Volvo.diagnosticsEngine()
Volvo.emptyTrunck()
print(Volvo.release)

Scania.windowsState = .open
Scania.trunkVolume = 8000
Scania.trunkVolume = -3650
Scania.diagnosticsEngine()
Scania.emptyTrunck()
print(Scania.release)
>>>>>>> Lesson_3
