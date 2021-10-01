import Cocoa
import Foundation

enum engineState: String{
    case on = "Двигатель запущен"
    case off = "Двигатель заглушен"
}

enum windowsState: String{
    case open = "Окна открыты"
    case close = "Окна закрыты"
}

enum trunk {
    case empty(trunkEmpty: String)
    case full(trunkfull: String)
    case kg(volumeKG: Double)
}

enum spoilerStaticSportCar: String{
    case raised = "Спойлер поднят"
    case hidden = "Спойлер спрятон"
}

enum NOSStationSportCar{
    case on
    case off
}




class Car{
    let mark: String
    let release: Int
    let volumeTrunk: trunk
    var actionEngine: engineState
    var window: windowsState
    var staticTrunk: trunk

    
    init(mark: String, release: Int, vTrunk: trunk, actionEngine: engineState,window: windowsState, trunk: trunk){
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
var car2 = Car(mark: "Ford", release: 2020, vTrunk: .kg(volumeKG: 380), actionEngine: .on, window: .close, trunk: .empty(trunkEmpty: "Багажник пуст"))
print(car2.actionEngine.rawValue)
class SportCar: Car{
    
    var spoiler: spoilerStaticSportCar
    var NOS: NOSStationSportCar = .off
    
    init(mark: String, release: Int, vTrunk: trunk, actionEngine: engineState, window: windowsState, trunk: trunk, spoiler: spoilerStaticSportCar) {
        self.spoiler = spoiler
        super.init(mark: mark, release: release, vTrunk: vTrunk, actionEngine: actionEngine, window: window, trunk: trunk)
    }
    
    //Функция выключает двигатель и закрывает окна
    
    override func activeEngine(action: engineState){
        switch action {
        case .off:
            self.actionEngine = .off
            self.window = .close
            print("\(actionEngine.rawValue),\(self.window)")
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
}
class TrunkCar: Car{
    
}



var car1 = SportCar(mark: "Ford", release: 2020, vTrunk: .kg(volumeKG: 380), actionEngine: .on, window: .close, trunk: .empty(trunkEmpty: "Багажник пуст"), spoiler: .hidden)
car1.spoilerAction(action: .raised)
car1.NOSAction(action: .on)


