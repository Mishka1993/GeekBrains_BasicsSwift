import Cocoa
import Foundation
import Darwin

enum engineState: String{
    case on = "Двигатель запущен"
    case off = "Двигатель заглушен"
}

enum windowsState: String{
    case open = "Окна открыты"
    case close = "Окна закрыты"
}

enum trunkStatic {
    case empty
    case half
    case full
    case kg(volumeKG: Double)
}

protocol Car{
    var mark: String{get}
    var release: Int{get}
    static var carCount: Int {get set}
}

extension Car{
    func activeEngine(active: engineState){
        switch active{
        case .on: break
        case .off: break
        }
    }
    func activeWindows(active: engineState){
        switch active{
        case .on: break
        case .off: break
        }
    }
}

class SportCar: Car{
    let mark: String
    let release: Int
    let volumeTrunk: trunkStatic
    var actionEngine: engineState
    var window: windowsState
    var staticTrunk: trunkStatic
    static var carCount = 0
    var spoiler: spoilerStaticSportCar
    var NOS: NOSStationSportCar = .off
    
    init(mark: String, release: Int, vTrunk: trunkStatic, actionEngine: engineState,window: windowsState, trunk: trunkStatic, spoiler: spoilerStaticSportCar){
        self.mark = mark
        self.release = release
        self.window = window
        self.staticTrunk = trunk
        self.actionEngine = actionEngine
        self.volumeTrunk = vTrunk
        self.spoiler = spoiler
        SportCar.carCount += 1
    }
    deinit{
        SportCar.carCount -= 1
        print("Таких авто больше нет")
    }
    
    enum spoilerStaticSportCar: String{
        case raised = "Спойлер поднятый"
        case hidden = "Спойлер спрятон"
    }

    enum NOSStationSportCar{
        case on
        case off
    }
      
    //Функция выключает двигатель и закрывает окна
    
    func activeEngine(action: engineState){
        switch action {
        case .off:
            self.actionEngine = .off
            self.window = .close
            print("\(actionEngine.rawValue),\(self.window.rawValue)")
        case .on:
            self.actionEngine = .on
            print("\(actionEngine.rawValue)")
        }
    }
    
    func activeWindows(active: windowsState){
     switch active{
     case .open:
         self.window = .open
         print("\(window.rawValue)")
     case .close:
         self.window = .close
         print("\(window.rawValue)")
        }
    }
    //Функция поднимает спойлер и опускает спойлер. Если поднят окра закрываются, иначе окна открыты
    
    func spoilerAction(action: spoilerStaticSportCar){

        switch action {
        case .hidden:
            self.spoiler = .raised
            self.window = .close
            print("\(spoiler.rawValue), \(self.window.rawValue)")
        case .raised:
            self.spoiler = .hidden
            self.window = .open
            print("\(spoiler.rawValue), \(self.window.rawValue)")
        }
    }
    
    //Функция запускает нитро и отключает через 5 секунд
    
    func NOSAction(action: NOSStationSportCar){
        self.NOS = action
        print("\(self.mark) нитро включино")
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if self.NOS == .on {
                self.NOS = .off
                print("\(self.mark) нитро выключено")
            }
        }
    }
}
extension SportCar: CustomStringConvertible{
    var description: String{
        return"Авто марки \(mark), \(release) года выпуска. Двигатель \(actionEngine.rawValue). Объем багажника \(volumeTrunk). \(spoiler.rawValue)."
    }
}

class TrunkCar: Car{
    let mark: String
    let release: Int
    let volumeTrunk: trunkStatic
    var actionEngine: engineState
    var window: windowsState
    var staticTrunk: trunkStatic
    static var carCount = 0
    var Lights: LightsStatic = .off
    
    init(mark: String, release: Int, vTrunk: trunkStatic, actionEngine: engineState,window: windowsState, trunk: trunkStatic){
        self.mark = mark
        self.release = release
        self.window = window
        self.staticTrunk = trunk
        self.actionEngine = actionEngine
        self.volumeTrunk = vTrunk
        SportCar.carCount += 1
    }
    deinit{
        SportCar.carCount -= 1
        print("Таких авто больше нет")
    }
    
    enum LightsStatic: String{
        case on = "Фары включены"
        case off = "Фары выключены"
    }
    
    func activeEngine(action: engineState){
        switch action {
        case .off:
            self.actionEngine = .off
        case .on:
            self.actionEngine = .on
        }
    }
    
    func activeWindows(active: windowsState){
     switch active{
     case .open:
         self.window = .open
         print("\(window.rawValue)")
     case .close:
         self.window = .close
         print("\(window.rawValue)")
        }
    }
    
    //Функция определяет текущее время и решает включить фары или нет
    func activeFogLights(active: LightsStatic){
        
        let Time = (Calendar.current.component(.hour, from: Date()))
        
        switch active{
        case .on:
            if(Time >= 17){
                self.Lights = .on
                print("Время \(Time). Фары включены")
            }else{
                print("Время \(Time). Светло, фары не нужны")
            }
        case .off:
            self.Lights = .off
            print("Фары выключены")
        }
    }
}

extension TrunkCar: CustomStringConvertible{
    var description: String{
        return"Авто марки \(mark), \(release) года выпуска. Двигатель \(actionEngine.rawValue). Объем багажника \(volumeTrunk). \(Lights.rawValue)."
    }
}
var TrunkCarVolvo = TrunkCar(mark: "Volvo", release: 2009, vTrunk: .kg(volumeKG: 12000), actionEngine: .off, window: .close, trunk: .empty)

TrunkCarVolvo.activeEngine(action: .off)
print(TrunkCarVolvo.actionEngine.rawValue)
print(TrunkCarVolvo.release)
TrunkCarVolvo.activeFogLights(active: .on)
print(TrunkCarVolvo.description)



var SportCarFord = SportCar(mark: "Ford", release: 2020, vTrunk: .kg(volumeKG: 380), actionEngine: .on, window: .close, trunk: .empty, spoiler: .hidden)

SportCarFord.activeEngine(action: .off)
print(SportCarFord.actionEngine.rawValue)
print(SportCarFord.release)
SportCarFord.spoilerAction(action: .raised)
print(SportCarFord.description)
SportCarFord.NOSAction(action: .on)


