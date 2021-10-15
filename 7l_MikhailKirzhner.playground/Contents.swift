import Cocoa
import Foundation


enum CinemaFilmErrors: Error{
    case inCinemaNotThisFilm
    case noFreePlaces
    case notEnoughMoney
}
struct Film{
    var price: Int
    var numberOfSeats: Int
}

class Cinema{
    var amountOfUserMoney = 300
    
    var moviesInCinema = [
            "Venom": Film(price: 240, numberOfSeats: 150),
            "Harry Potter": Film(price: 280, numberOfSeats: 45),
            "Matrix": Film(price: 320, numberOfSeats: 3)]
    
    func getTheFilm(withName: String) throws {
            guard var film = moviesInCinema[withName] else {
                throw CinemaFilmErrors.inCinemaNotThisFilm
            }
            guard film.numberOfSeats > 0 else {
                throw CinemaFilmErrors.noFreePlaces
            }
            guard  film.price <= amountOfUserMoney else {
                throw CinemaFilmErrors.notEnoughMoney
            }
            amountOfUserMoney -= film.price
            film.numberOfSeats -= 1
            moviesInCinema[withName] = film
            print("Вы купили билет на фильм: \(withName)")
        }
}

let сinema = Cinema()
try? сinema.getTheFilm(withName: "Venom")
сinema.amountOfUserMoney
сinema.moviesInCinema


do {
    try сinema.getTheFilm(withName: "Matrix")
} catch CinemaFilmErrors.inCinemaNotThisFilm {
    print("Такого фильма нет в кино")
} catch CinemaFilmErrors.notEnoughMoney{
    print("Не хвататет денег")
}
