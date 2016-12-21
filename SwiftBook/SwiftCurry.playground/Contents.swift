//: Playground - noun: a place where people can play
// https://www.objc.io/books/functional-swift/preview/#wrapping-core-image
// Currying in Swift

// Extra: https://robots.thoughtbot.com/introduction-to-function-currying-in-swift
// Extra: http://oleb.net/blog/2014/07/swift-instance-methods-curried-functions/
// Extra: http://stackoverflow.com/questions/36314/what-is-currying
// Extra: https://en.wikipedia.org/wiki/Currying

import UIKit

/*
 The add1 function takes two integer arguments and returns their sum. In Swift, however, we can define another version of the same function:
 */
func add1(_ x: Int, _ y: Int) -> Int {
    return x + y
}

/*
 The function add2 takes one argument, x, and returns a closure, expecting a second argument, y. This is exactly the same structure we used for our filter functions.
 */
func add2(_ x: Int) -> ((Int) -> Int) {
    return { y in
        x + y
    }
}

/*
 Because the function arrow is right-associative, we can remove the parentheses around the result function type. As a result, the function add3 is exactly the same as add2:
 */
func add3(_ x: Int) -> (Int) -> Int {
    return { y in
        x + y
    }
}

add1(1, 2) // 3
add2(1)(2) // 3
add3(1)(2) // 3

/*
 In the first case, we pass both arguments to add1 at the same time; in the second case, we first pass the first argument, 1, which returns a function, which we then apply to the second argument, 2. Both versions are equivalent: we can define add1 in terms of add2, and vice versa.
 */

/*
 The add1 and add2 examples show how we can always transform a function that expects multiple arguments into a series of functions that each expects one argument. This process is referred to as currying, named after the logician Haskell Curry; we say that add2 is the curried version of add1.
 */

/*
 So why is currying interesting? As we’ve seen in this book thus far, there are scenarios where you want to pass functions as arguments to other functions. If we have uncurried functions, like add1, we can only apply a function to both its arguments at the same time. On the other hand, for a curried function, like add2, we have a choice: we can apply it to one or two arguments.
 */