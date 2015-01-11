//
//  GameController.swift
//  Puzzle
//
//  Created by David Christy on 07/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import Foundation

protocol CardTappedProtocol {
    func cardTapped(row: Int, column: Int)
}

protocol ResolveMatchingCardsResultProtocol {
    func resolveMatchingCardsResult(result: CardsMatchingResult)
}

class GameEngine: CardTappedProtocol {
    
    private var gameBoard: GameBoard?
    private var firstCardTapped: (row: Int, column: Int)?
    private let delegate: ResolveMatchingCardsResultProtocol
    
    init(delegate: ResolveMatchingCardsResultProtocol) {
        self.delegate = delegate
    }
    
    // TODO: add cards'theme as parameter
    func setupNewGame(rows: Int, columns: Int){
        gameBoard = GameBoard(rows: rows, columns: columns)
        
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
    
    func getGameBoardCards() -> [CardViewModel] {
        let board = gameBoard?.board
        let (rows,columns) = gameBoard!.getDimensions()
        
        let indexes = map(0..<gameBoard!.board.count, { $0 })
        
        let viewModels = indexes.map{CardViewModel(row: $0 % rows, column: $0 % columns, cardSlot: board![$0])}
        return viewModels
    }
    
//    private func cardHasBeenTapped(cardType: CardType) {
//        let cards = (firstCardTapped, cardType)
//        switch cards {
//        case (nil, _):
//            firstCardTapped = cardType
//        case (_ , _) where cards.0 == cards.1:
//            // Matching
//            firstCardTapped = nil
//            println("Matching!")
//        default:
//            // Not matching
//            firstCardTapped = nil
//            println("Not matching!")
//        }
//    }
    
    // CardTappedProtocol
    func cardTapped(row: Int, column: Int) {
        if let (r,c) = firstCardTapped {
            firstCardTapped = nil
            let r = gameBoard?.doCardsMatch(r, columnFirstCard: c, rowSecondCard: row, columnSecondCard: column)
            self.delegate.resolveMatchingCardsResult(r!)
        } else {
            // TODO: prevent same card to be tapped
            firstCardTapped = (row, column)
        }
    }
}