//
//  CardViewModel.swift
//  Puzzle
//
//  Created by David Christy on 10/01/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

struct CardViewModel {
    let row: Int, column: Int
    let cardSlot: CardSlot
    
    init(row: Int, column: Int, cardSlot: CardSlot) {
        self.row = row
        self.column = column
        self.cardSlot = cardSlot
    }
}