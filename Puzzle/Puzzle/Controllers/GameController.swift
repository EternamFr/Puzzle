//
//  GameController.swift
//  Puzzle
//
//  Created by David Christy on 07/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import Foundation

class GameEngine {
    
    private var gameBoard: GameBoard?
    
    init() {
        
    }
    
    // TODO: add rows/columns as parameter as well as cards'theme
    func setupNewGame(){
        gameBoard = GameBoard(rows: 3, columns:2)
        
        populateGameBoardWithPairsOfCards(&gameBoard!)
    }
    
    private func populateGameBoardWithPairsOfCards(inout board: GameBoard) {
        let dimensions = gameBoard!.getDimensions()
        
        var ct: CardType?
        var binome: Int = 0
        for c in 0..<dimensions.columns {
            for r in 0..<dimensions.rows {
                if ct == nil {
                    ct = CardType.getRandomCardType()
                }
                binome += 1  
                gameBoard?[r, c] = CardSlot.Card(ct!)
                
                if binome == 2 {
                    ct = nil
                    binome = 0
                }
            }
        }
    }
    
}
