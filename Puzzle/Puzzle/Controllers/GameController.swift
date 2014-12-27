//
//  GameController.swift
//  Puzzle
//
//  Created by David Christy on 07/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import Foundation

class GameEngine: CardTappedProtocol {
    
    private var gameBoard: GameBoard?
    private var firstCardTapped: CardType?
    
    init() {
    }
    
    // TODO: add rows/columns as parameter as well as cards'theme
    func setupNewGame(){
        gameBoard = GameBoard(rows: 2, columns:3)
        
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
    
    private func cardHasBeenTapped(cardType: CardType) {
        let cards = (firstCardTapped, cardType)
        switch cards {
        case (nil, _):
            firstCardTapped = cardType
        case (_ , _) where cards.0 == cards.1:
            // Matching
            firstCardTapped = nil
        default:
            // Not matching
            firstCardTapped = nil
        }
    }
    
    func cardTapped(row: Int, column: Int) {
        let cardSlotAt = gameBoard?[row,column]
        
        switch cardSlotAt! {
        case .Empty:
            break
        case let .Card(ct):
            cardHasBeenTapped(ct)
        }
    }
}
