//: Playground - noun: a place where people can play

import UIKit

// Inheritance

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) km per hour"
    }
    
    func makeNoise() {
        // do Nothing
    }
}

let someVehicle = Vehicle()
print(someVehicle.description)


class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")


class Tendem: Bicycle {
    // Tendem is Two seater Bicycle
    var currentNumberOfPassengers = 0
}

let tendem = Tendem()
tendem.hasBasket = true
tendem.currentSpeed = 20.0
tendem.currentNumberOfPassengers = 2
print("Tendem: \(tendem.description)")



// Overriding Methods
class Train: Vehicle {
    override func makeNoise() {
        print ("Chook Chook")
    }
}

let train = Train()
train.makeNoise()


// Overriding Properties
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let car = Car()
car.gear = 4
car.currentSpeed = 75
print("Car : \(car.description)")



// Overriding Property Observers
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            // Changes gear based on currentSpeed
            gear = Int((currentSpeed / 10.0) + 1)
        }
    }
}

let automaticCar = AutomaticCar()
automaticCar.currentSpeed = 85
print("AutomaticCar : \(automaticCar.description)")


