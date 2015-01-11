//
//  GameBoard.swift
//  Puzzle
//
//  Created by David Christy on 09/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import Foundation

struct GameBoard {
   
    let rows: Int, columns: Int
    var board: [CardSlot]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        
        board = Array(count: rows * columns, repeatedValue: CardSlot.Empty)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    func getDimensions() -> (rows: Int, columns: Int) {
        return (self.rows, self.columns)
    }
    
    subscript(row: Int, column: Int) -> CardSlot {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return board[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            board[(row * columns) + column] = newValue
        }
    }

}

/// An enum representing either an empty cardslot or a card upon the board.
enum CardSlot {
    case Empty
    case Card(CardType)
    
    func getCardType() -> CardType {
        switch self {
        case .Empty: return CardType.None
        case let .Card(ct): return ct
        }
    }
}

enum CardType: Int {
    case None = 0
    case Lion = 1
    case Crocodile, Donkey, GreatHorn
    
    func simpleDescription() -> String {
        switch self {
        case .Lion:
            return "Lion"
        case .Crocodile:
            return "Crocodile"
        case .Donkey:
            return "Donkey"
        case .GreatHorn:
            return "GreatHorn"
        default:
            return "A card must be given a name!"
        }
    }
    
    static func getCardTypeCount() -> Int {
        return 4
    }
    
    static func getRandomCardType() -> CardType {
        // TODO: add the possibility to choose a set of card based on a theme (jungle, pirate, halloween...)
        srandom(arc4random())
        let randomInt = random() % getCardTypeCount()
        println(randomInt)
        if let cardType = CardType(rawValue: randomInt) {
            return cardType
        }
        
        return CardType.Lion // Ask Léon why
    }
    
}

typealias IsGameOver = Bool

// An enum representing whether 2 cardslots match or not and if the game is over
enum CardSlotsMatchingResult {
    case DontMatch
    case DoMatch(IsGameOver)
}