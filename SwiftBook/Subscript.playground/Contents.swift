//: Playground - noun: a place where people can play

import UIKit
import CoreFoundation


// Subscript

struct TimesTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("threeTimesTable: \(threeTimesTable[6])")


// Subscript Options
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of bound")
            return grid[(row * columns) + column]
        }
        
        set(newValue) {
            assert(indexIsValid(row: row, column: column), "Index out of bound")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix[rows: 5, columns: 5]
matrix[0, 1] = 5
matrix[1, 0] = 6

let someValue = matrix[0, 1]
print(someValue)
// Subscript Options
