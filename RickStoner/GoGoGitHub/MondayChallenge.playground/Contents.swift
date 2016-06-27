//: Playground - noun: a place where people can play

import UIKit

let arrayOfInts = [3, 5, 1, 6, 2, 5]

func minimize(arrayOfInts: [Int]) -> [[Int]] {
    
    var middleArray = [Int]()
    for index in 0..<(arrayOfInts.count - 1) {
        middleArray.append(arrayOfInts[index])
    }
    let beginning: [Int] = [arrayOfInts[0]]
    let last: [Int] = [arrayOfInts.last!]
    let minimizedArray = [beginning, middleArray, last]
    
    return minimizedArray
}

let newArray = minimize(arrayOfInts)

newArray.count

