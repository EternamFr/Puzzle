//
//  GameController.swift
//  Puzzle
//
//  Created by David Christy on 07/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import Foundation
import UIKit

class GameEngine {

    let _dimensionX: Int
    let _dimensionY:Int
    let _size: CGRect
    var _board:[Card]
    
    init(dimensionX: Int, dimensionY:Int, size:CGRect) {
        _dimensionX = dimensionX
        _dimensionY = dimensionY
        _size = size
        _board = [Card]()
    }
    
    func initializeNewGame(){
        for index in 1...(_dimensionX * _dimensionY){
            let c = Card(type: .Lion)
            _board[index - 1] = c
        }
    }
    
}

struct Card {
    
    var type:CardType
    
}

enum CardType{
    case Lion,Crocodile,Donkey,GreatHorn
    
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
    
}
