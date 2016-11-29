//: Playground - noun: a place where people can play

import UIKit
import Foundation

// Initialization

struct Fahrenheit {
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
}

let fahrenheit = Fahrenheit()
print("The default temperature is: \(fahrenheit.temperature) Fahrenheit")


// Initialization Parameters
struct Celsius {
    
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 237.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 237.15)
let bodyTemperature = Celsius(37.0)

print("boilingPointOfWater is: \(boilingPointOfWater.temperatureInCelsius) Celsius")
print("freezingPointOfWater is: \(freezingPointOfWater.temperatureInCelsius) Celsius")
print("bodyTemperature is: \(bodyTemperature.temperatureInCelsius)")



// Parameter Names and Argument Labels
struct Color {
    
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magentaColor = Color(red: 1.0, green: 0.0, blue:1.0)
let grayColor = Color(white: 0.5)

print(magentaColor)
print(grayColor)



// Optional Property Types
class SurveyQuestions {
    let text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestions(text: "Do you like Cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes I Do like it!"
print(cheeseQuestion.response!)

let beetQuestion = SurveyQuestions(text: "What about beets?")
beetQuestion.ask()
beetQuestion.response = "Yes, but not with Cheese!"
print(beetQuestion.response!)



// Default Initializers
class ShoppingList {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingList()
dump(item)


// Initializer Inheritance and Overriding
class Vehicle {
    var numnerOfWheels = 0
    var description: String {
        return "\(numnerOfWheels) wheel(s)"
    }
}

class Bicyle: Vehicle {
    override init() {
        super.init()
        numnerOfWheels = 2
    }
}

let bicyle = Bicyle()
print("Bicyle: \(bicyle.description)")




// Designated and Convenience Initializers in Action
class Food {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[noname]")
    }
}

class RecipeIngredient: Food {
    
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var descripiton: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange Juice"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.descripiton)
}


// Failable Initializers

struct Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}


let someCreature = Animal(species: "Girrafe")

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}


let annonymousCreature = Animal(species: "")

if annonymousCreature == nil {
    print("The annonymous creature could not be initialized")
}


// Failable Initializers for Enumerations
enum TemperatureUnit {
    
    case kelvin, celcius, fahrenheit
    
    init?(symbol: Character) {
        
        switch symbol {
        
        case "K":
            self = .kelvin
        
        case "C":
            self = .celcius
        
        case "F":
            self = .fahrenheit
        
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheit != nil {
    print("This is a defined temperature unit, initialization succeeded.")
}

let unkwonUnit = TemperatureUnit(symbol: "X")
if  unkwonUnit == nil {
    print("This is not a definded temperature unit, initialization failed.")
}


// Required Initializers

class SomeClass {
    required init() {
    // initializer implementation goes here
    }
}

class SomeSubClass: SomeClass {
    required init() {
        
    }
}

// Setting a Default Property Value with a Closure or Function
struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board)


