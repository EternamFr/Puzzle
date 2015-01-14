//
//  GameController.swift
//  Puzzle
//
//  Created by David Christy on 07/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import Foundation

protocol CardTappedProtocol {
    func cardTapped(column: Int, row: Int)
}

protocol ResolveMatchingCardsResultProtocol {
    func resolveMatchingCardsResult(result: CardsMatchingResult)
}

class GameEngine: CardTappedProtocol {
    
    private var gameBoard: GameBoard?
    private var firstCardTapped: (column: Int, row: Int)?
    private let delegate: ResolveMatchingCardsResultProtocol
    
    init(delegate: ResolveMatchingCardsResultProtocol) {
        self.delegate = delegate
    }
    
    // TODO: add cards'theme as parameter
    func setupNewGame(columns: Int, rows: Int){
        gameBoard = GameBoard(columns: columns, rows: rows)
    }
    
    func getGameBoardCards() -> [CardViewModel] {
        let board = gameBoard?.board
        let (columns, rows) = gameBoard!.getDimensions()
        
        let indexes = map(0..<gameBoard!.board.count, { $0 })
        
        let viewModels = indexes.map{CardViewModel(column: $0 % columns,row: $0 / columns, type: board![$0].type)}
        return viewModels
    }
    
    // CardTappedProtocol
    func cardTapped(column: Int, row: Int) {
        if let (columnFirst, rowFirst) = firstCardTapped {
            firstCardTapped = nil
            let r = gameBoard?.doCardsMatch(columnFirst, rowFirstCard: rowFirst, columnSecondCard: column, rowSecondCard: row)
            self.delegate.resolveMatchingCardsResult(r!)
        } else {
            // TODO: prevent same card to be tapped
            firstCardTapped = (column, row)
        }
    }
}