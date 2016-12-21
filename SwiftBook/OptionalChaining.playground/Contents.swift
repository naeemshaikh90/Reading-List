//: Playground - noun: a place where people can play

import UIKit

// Optional Chaining


// Optional Chaining as an Alternative to Forced Unwrapping
/*
class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

// let roomCount = john.residence!.numberOfRooms
// Runtime error

john.residence = Residence()

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) rooms(s).")
} else {
    print("Unable to retrieve the numbers of rooms.")
}
*/


// Defining Model Classes for Optional Chaining
class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

// Page 505
// Accessing Properties Through Optional Chaining
