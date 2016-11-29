//: Playground - noun: a place where people can play

import UIKit

// MARK:- Classes and Structures

// UpperCamelCase for class and struct
// lowerCamelCase for properties and methods

class SomeClass {
    // Class definition
}

struct SomeStructure {
    // Structure definition
}


// Class & Structure definition
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// Intances of Class & Structure
let someResolution = Resolution()
let someVideoMode = VideoMode()

// Access properties
print("The width of someResolution is: \(someResolution.width)")
print("The width of someVideoMode is: \(someVideoMode.resolution.width)")

// Assign a value
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now: \(someVideoMode.resolution.width)")


// Structure initializer
// All structures have an automatically-generated memberwise initializer
// Unlike structures, class instances do not receive a default memberwise initializer.
let vga = Resolution(width: 640, height: 480)
print("VGA Resolution: \(vga)")

//// Structures and Enumerations Are Value Types
// Structures as Value Types
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048

print("HD Resolution: \(hd)")
print("Cinema Resolution: \(cinema)")


// Enumerations as Value Types
enum CompassPoint {
    case north, south, east, west
}

var currentDirection = CompassPoint.west
var rememberedDirection = currentDirection
currentDirection = .east

if rememberedDirection == .west {
    print("rememberedDirection is still west")
}
print("currentDirection is: \(currentDirection)")
print("rememberedDirection is: \(rememberedDirection)")


//// Classes Are Reference Types
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.frameRate = 25.0
tenEighty.name = "1080i"
print("tenEighty BEFORE: \(tenEighty.frameRate)")

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("tenEighty AFTER: \(tenEighty.frameRate)")
print("alsoTenEighty: \(alsoTenEighty.frameRate)")

// Identity Operators (===) , (!==)
// To check if two constants or variables refer to exactly the same instance of a class

// Identical to (===)
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty are both same")
} else {
    print("tenEighty and alsoTenEighty are not same")
}

// Not identical to (!==)
if tenEighty !== alsoTenEighty {
    print("tenEighty and alsoTenEighty are not same")
} else {
    print("tenEighty and alsoTenEighty are both same")
}

