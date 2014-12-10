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
}

enum CardType: Int {
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
    
    static func getRandomCardType() -> CardType {
        // TODO: add the possibility to choose a set of card based on a theme (jungle, pirate, halloween...)
        let randomInt = Int(arc4random_uniform(4))
        
        if let cardType = CardType(rawValue: randomInt) {
            return cardType
        }
        
        return CardType.Lion // Ask Léon why
    }
    
}