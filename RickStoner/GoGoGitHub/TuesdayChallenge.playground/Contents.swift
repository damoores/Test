//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"



func lowHigh(arrayOfNumbers: [Double]) -> (min: Double, max: Double)? {
    if arrayOfNumbers.isEmpty {
        return nil
    } else {
        let lowHigh: (min: Double, max: Double)
        lowHigh.max = arrayOfNumbers.maxElement()!
        lowHigh.min = arrayOfNumbers.minElement()!
        return lowHigh
    }
}

let arrayOfNumbers = [5.0, 3.4, 5.1, -4.0]
let highAndLow = lowHigh(arrayOfNumbers)

highAndLow?.max
highAndLow?.min

// or another method.. is it more efficient?

func lowHighBySort(arrayOfNumbers: [Double]) -> (min: Double, max: Double)? {
    if arrayOfNumbers.isEmpty {return nil }
    
    let sortedNumbers = arrayOfNumbers.sort()
    let lowHigh: (min: Double, max: Double)
    lowHigh.max = sortedNumbers.first!
    lowHigh.min = sortedNumbers.last!

    return lowHigh
}

let secondMethod = lowHighBySort(arrayOfNumbers)
secondMethod?.max
secondMethod?.min



