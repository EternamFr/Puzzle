//
//  CardBackType.swift
//  Puzzle
//
//  Created by David Christy on 16/02/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

enum CardBackType: Int {
    case None = 0
    case Jungle = 1
    case Pirate, Dinosaur, Halloween
    
    func simpleDescription() -> String {
        switch self {
        case .Jungle:
            return "Jungle"
        case .Pirate:
            return "Pirate"
        case .Dinosaur:
            return "Dinosaur"
        case .Halloween:
            return "Halloween"
        default:
            return "A cardBack must be given a name!"
        }
    }
    
}