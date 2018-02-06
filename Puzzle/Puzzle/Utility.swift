//
//  Utility.swift
//  Puzzle
//
//  Created by David Christy on 25/01/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

class Randomizer {

    class func getRandomInt(_ max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
    
    class func getRandomDouble(_ max: Int) -> Double {
        return Double(arc4random_uniform(UInt32(max)))
    }
}
