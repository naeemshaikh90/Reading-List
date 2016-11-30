//: Playground - noun: a place where people can play

import UIKit

// Automatic Reference Counting

class OtherPerson {
    
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var referenece1: OtherPerson?
var referenece2: OtherPerson?
var referenece3: OtherPerson?

referenece1 = OtherPerson(name: "John Doe")
referenece2 = referenece1
referenece3 = referenece1

referenece1 = nil
referenece2 = nil
referenece3 = nil

// “Strong Reference Cycles Between Class Instances”
class Person {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var apartment: Apartment?
    
    deinit {
        print("\(name) is being deinitiliazed")
    }
}

class Apartment {
    
    let unit: String
    
    init(unit: String) {
        self.unit = unit
    }
    
    // Weak References
    weak var tenant: Person?
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Applesses")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil


// Unowned References
class Customer {
    
    let name: String
    
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    
    let number: UInt64
    
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var Jenny: Customer?
Jenny = Customer(name: "Jenny Depdredsd")
Jenny!.card = CreditCard(number: 1234_1234_1234_1234, customer: Jenny!)


// start from 480 page