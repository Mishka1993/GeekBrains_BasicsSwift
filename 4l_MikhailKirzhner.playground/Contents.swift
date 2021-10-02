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


class Car{
    let mark: String
    let release: Int
    let volumeTrunk: trunkStatic
    var actionEngine: engineState
    var window: windowsState
    var staticTrunk: trunkStatic
    static var carCount = 0

    
    init(mark: String, release: Int, vTrunk: trunkStatic, actionEngine: engineState,window: windowsState, trunk: trunkStatic){
        self.mark = mark
        self.release = release
        self.window = window
        self.staticTrunk = trunk
        self.actionEngine = actionEngine
        self.volumeTrunk = vTrunk
    }
    
    func activeEngine(action: engineState){
        switch action {
        case .off:
            self.actionEngine = .off
        case .on:
            self.actionEngine = .on
        }
    }
    func discriptionCar(){
        print("Авто марки \(mark), \(release) года выпуска. Двигатель \(actionEngine.rawValue). Объем багажника \(volumeTrunk)")
    }
}

class SportCar: Car{
    
    enum spoilerStaticSportCar: String{
        case raised = "Спойлер поднятый"
        case hidden = "Спойлер спрятон"
    }

    enum NOSStationSportCar{
        case on
        case off
    }
    
    var spoiler: spoilerStaticSportCar
    var NOS: NOSStationSportCar = .off
    
        init(mark: String, release: Int, vTrunk: trunkStatic, actionEngine: engineState, window: windowsState, trunk: trunkStatic, spoiler: spoilerStaticSportCar) {
        self.spoiler = spoiler
        SportCar.carCount += 1
        super.init(mark: mark, release: release, vTrunk: vTrunk, actionEngine: actionEngine, window: window, trunk: trunk)
    }
    deinit{
        SportCar.carCount -= 1
        print("Таких авто больше нет")
    }
    //Функция выключает двигатель и закрывает окна
    
    override func activeEngine(action: engineState){
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
    
    override func discriptionCar(){
        print("Авто марки \(mark), \(release) года выпуска. Двигатель \(actionEngine.rawValue). Объем багажника \(volumeTrunk). \(spoiler.rawValue).")
    }
}
class TrunkCar: Car{
    
    enum LightsStatic: String{
        case on = "Фары включены"
        case off = "Фары выключены"
    }
    
    var Lights: LightsStatic = .off
    
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
    
    override func discriptionCar(){
        print("Авто марки \(mark), \(release) года выпуска. Двигатель \(actionEngine.rawValue). Объем багажника \(volumeTrunk). \(Lights.rawValue).")
    }
}


var TrunkCarVolvo = TrunkCar(mark: "Volvo", release: 2009, vTrunk: .kg(volumeKG: 12000), actionEngine: .off, window: .close, trunk: .empty)

TrunkCarVolvo.activeEngine(action: .off)
print(TrunkCarVolvo.actionEngine.rawValue)
print(TrunkCarVolvo.release)
TrunkCarVolvo.activeFogLights(active: .on)
SportCarFord.discriptionCar()



var SportCarFord = SportCar(mark: "Ford", release: 2020, vTrunk: .kg(volumeKG: 380), actionEngine: .on, window: .close, trunk: .empty, spoiler: .hidden)

SportCarFord.activeEngine(action: .off)
print(SportCarFord.actionEngine.rawValue)
print(SportCarFord.release)
SportCarFord.spoilerAction(action: .raised)
SportCarFord.discriptionCar()
SportCarFord.NOSAction(action: .on)


