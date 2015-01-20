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
    
    static func getRandomCardTypes(number: Int) -> [CardType] {
        assert(number % 2 == 0, "Number of random card types required must be even.")
        // TODO: add the possibility to choose a set of card based on a theme (jungle, pirate, halloween...)
        
        // Put the card types in an a list
        var types = [Int]()
        for t in CardType.Lion.rawValue...CardType.GreatHorn.rawValue {
            types.append(t)
        }
        
        func shuffle<T>(inout t:Array<T>, iteration:Int = 9) {
            for i in 0...iteration {
                let swapPosition1 = Int(arc4random_uniform(UInt32(t.count)))
                let swapPosition2 = Int(arc4random_uniform(UInt32(t.count)))
                
                let temp = t[swapPosition1]
                t[swapPosition1] = t[swapPosition2]
                t[swapPosition2] = temp
            }
        }
        
        shuffle(&types)
        
        var cards = [CardType]()
        for i in 1...number/2 {
            cards.append(CardType(rawValue: types[i])!)
            cards.append(CardType(rawValue: types[i])!)
        }
        
        shuffle(&cards, iteration: 29)
        
        return cards
    }

}