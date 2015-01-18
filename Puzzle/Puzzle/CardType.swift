//
//  CardType.swift
//  Puzzle
//
//  Created by David Christy on 14/01/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

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
        let randomInt: Int = Int(rand()) % (getCardTypeCount() - 1)
        println(randomInt)
        if let cardType = CardType(rawValue: randomInt) {
            return cardType
        }
        
        return CardType.Lion // Ask Léon why
    }

}