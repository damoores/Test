//: Playground - noun: a place where people can play

import UIKit

//interpretted the challenge two seperate ways

func middleThree(arrayOfInts: [Int]) -> [Int]? {
    let middle: Int
    if arrayOfInts.count % 2 == 0 {
        print("need an array with an odd number")
        return nil
    } else {
        middle = arrayOfInts.count / 2
    }
    let middleThree = [arrayOfInts[middle - 1], arrayOfInts[middle], arrayOfInts[middle + 1]]
    
    return middleThree
}

let arrayOfInts = [3, 5, 1, 6, 2, 5, 7]
let arrayOfInts2 = [3, 5, 1]

let middleThreeResult = middleThree(arrayOfInts)
let middleThreeResult2 = middleThree(arrayOfInts2)

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




