//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

import Cocoa
import Foundation

struct Queue<T> {
    private var array = [T]()
    
    mutating func enqueue(_ item: T) {
        array.append(item)
    }
    
    mutating func dequeue() -> T? {
        if array.count < 0 {
            return nil
        }
        return array.removeFirst()
    }
    
    func filter( _ predicate: (T) -> Bool ) -> [T] {
        var result = [T]()
        for i in array {
            if predicate(i) {
                result.append(i)
            }
        }
        return result
    }
    
    func map10<U>(_ transformPredicate: (T) -> U) -> [U] {
        var result = [U]()
        for i in array {
            let newItem = transformPredicate(i) as! Int * 10
            result.append(newItem as! U)
        }
        
        return result
    }
    
    subscript(index: Int) -> T? {
        if index > array.count && index <= 0 {
            return nil
        }
        return array[index]
    }
}

extension Queue : CustomStringConvertible {
    var description: String {
        return "\(Array(array.reversed()))"
    }
}

var queue = Queue<Int>()
queue.enqueue(10)
queue.enqueue(15)
queue.enqueue(29)

let filter = queue.filter({$0 % 2 == 0})
let map = queue.map10({$0})
print(queue)
print(filter)
print(map)
