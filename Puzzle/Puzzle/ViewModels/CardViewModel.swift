//
//  CardViewModel.swift
//  Puzzle
//
//  Created by David Christy on 10/01/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

struct CardViewModel {
    let column: Int
    let row: Int
    let type: CardType
    
    init(column: Int, row: Int, type: CardType) {
        self.column = column
        self.row = row
        self.type = type
    }
}