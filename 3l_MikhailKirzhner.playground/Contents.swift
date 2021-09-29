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
    var freeSpaceTrunk: UInt = 0
    var emptyTrunk: UInt
    
    init(mark: String, release: Int, trunkVolume: UInt){
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
                print ("\(mark)\(newValue)")
            } else {
                print("\(mark)\(newValue)")
            }
        }
    }
    
    
    var trunkVolume: UInt{
        willSet{
            if trunkState == .empty && trunkVolume >= 0 && newValue < trunkVolume {
                self.freeSpaceTrunk = self.trunkVolume - newValue
                print ("В \(mark) загружено \(newValue), свободного места: \(freeSpaceTrunk)л")
            }else if (trunkState == .half){
                freeSpaceTrunk = freeSpaceTrunk - newValue
                print ("В \(mark) загружено \(newValue), свободного места: \(freeSpaceTrunk)л")
            }
//            else if trunkState == .half && freeSpaceTrunk > 0 {
//                freeSpaceTrunk = trunkVolume
//                print("В \(mark) \(newValue)л столько не влезет, свободного места: \(freeSpaceTrunk)л")
//            }
            
            
            if freeSpaceTrunk == self.emptyTrunk {
                trunkState = .empty
            }else if freeSpaceTrunk == 0{
                trunkState = .full
            }else if freeSpaceTrunk > 0 && freeSpaceTrunk < self.emptyTrunk{
                trunkState = .half
            }
        }
    }
    /*
     mutating func emptyTrunck() {
         self.trunkState = .empty
         trunkVolume = emptyTrunk
         freeSpaceTrunk = 0
         print ("У автомобиле марки \(mark) все загружено из багажника")
     }
     
     */
}

var car = SportCar(mark: "Honda", release: 2016, trunkVolume: 320)
car.engineState = .off
car.trunkVolume = 120
car.trunkVolume = 110
car.trunkVolume = 40

