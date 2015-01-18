//
//  CardLocation.swift
//  Puzzle
//
//  Created by David Christy on 18/01/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation

struct CardLocation: Equatable {
    let column: Int
    let row: Int
    
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }

}

func == (lhs: CardLocation, rhs: CardLocation) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
}