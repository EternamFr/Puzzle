//
//  Card.swift
//  Puzzle
//
//  Created by David Christy on 14/01/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

struct Card {
    
    let column: Int
    let row: Int
    let type: CardType
    
    init(column: Int, row: Int, cardType: CardType){
        self.column = column
        self.row = row
        self.type = cardType
    }
    
    
}