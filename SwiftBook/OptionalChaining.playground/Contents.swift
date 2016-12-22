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
    init(name: String) { self.name = name }
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

let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) rooms(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "20"
someAddress.street = "Buckingham street"
john.residence?.address = someAddress

func createAddress() -> Address {
    print("function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "78"
    someAddress.street = "Alphensitine Road"
    
    return someAddress
}

john.residence?.address = createAddress()

// Calling Methods Through Optional Chaining
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (john.residence?.address = someAddress) != nil {
    print("It was possible to set address.")
} else {
    print("It was not possible to set address.")
}


// Accessing Subscripts Through Optional Chaining
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

john.residence?[0] = Room(name: "Bathroom")

let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Living Room"))
johnHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

// Accessing Subscripts of Optional Type
var testScores = ["Dave": [82, 86, 84], "John": [79, 59, 68]]
testScores["Dave"]?[0] = 91
testScores["John"]?[0] *= 10
testScores["Brian"]?[0] = 72


// Linking Multiple Levels of Chaining
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Lords Plaza"
johnsAddress.street = "Sprinkly Park Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}


// Chaining on Methods with Optional Return Values
if let buildingIdentifier = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    print("John's building identifier is \(buildingIdentifier).")
}

if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begins with \"The\".")
    }
}