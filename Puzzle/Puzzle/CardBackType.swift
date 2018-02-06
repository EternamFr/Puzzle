//
//  CardBackType.swift
//  Puzzle
//
//  Created by David Christy on 16/02/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

enum CardBackType: Int {
    case none = 0
    case jungle = 1
    case pirate, dinosaur, halloween
    
    func simpleDescription() -> String {
        switch self {
        case .none:
            return "A cardBack must be given a name!"
        case .jungle:
            return "Jungle"
        case .pirate:
            return "Pirate"
        case .dinosaur:
            return "Dinosaur"
        case .halloween:
            return "Halloween"
        }
    }
    
}
