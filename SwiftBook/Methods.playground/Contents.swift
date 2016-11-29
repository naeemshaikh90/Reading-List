//: Playground - noun: a place where people can play

import UIKit
import CoreFoundation

// Methods
// Two types Instance Methods and Type Methods

// Instance Methods
class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()

counter.increment()
print(counter.count)

counter.increment(by: 5)
print(counter.count)

counter.reset()
print(counter.count)
// Instance Methods

// The self Property
struct Point {
    var x = 0.0, y = 0.0
    func isItToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 10.0)
print(somePoint.isItToTheRightOf(x: 1.0))

// The self Property

// Modifying Value Types from Within Instance Methods
struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint = Point(x: 15.0, y: 15.0)
print(somePoint)

somePoint.moveBy(x: 5.0, y: 7.0)
print(somePoint)
// Modifying Value Types from Within Instance Methods


// Assigning to self Within a Mutating Method
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}
var somePoint = Point(x: 12.0, y:13.0)
print(somePoint)

somePoint.moveBy(x: 3, y: 2)
print(somePoint)

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low

for i in 0..<9{
    ovenLight.next()
    print(ovenLight)
}
// Assigning to self Within a Mutating Method




// Type Methods
struct LevelTracker {
    static var highestLevelUnlocked = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestLevelUnlocked {
            highestLevelUnlocked = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestLevelUnlocked
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "John Doe")
player.complete(level: 4)
dump(LevelTracker.highestLevelUnlocked)

player = Player(name: "Barak Obama")
if player.tracker.advance(to: 6) {
    print("Level is Unlocked")
} else {
    print("Level is locked")
}

// Type Methods
