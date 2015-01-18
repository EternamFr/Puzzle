//
//  GameMatchingResult.swift
//  Puzzle
//
//  Created by David Christy on 14/01/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

typealias IsGameOver = Bool

// An enum representing whether 2 cards match or not and if the game is over
enum Result {
    case DontMatch
    case DoMatch(IsGameOver)
}

struct CardsMatchingResult {
    let result: Result
    let cardLocations: [CardLocation]
    
    init(result: Result, cardLocations: [CardLocation]) {
        self.result = result
        self.cardLocations = cardLocations
    }
}
