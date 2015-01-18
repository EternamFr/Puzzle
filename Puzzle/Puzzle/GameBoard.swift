//
//  GameBoard.swift
//  Puzzle
//
//  Created by David Christy on 09/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import Foundation

protocol PGameBoardModelNotification {
    func cardsAdded([CardViewModel]);
    func cardsRemoved([CardViewModel]);
    func cardSelected(CardViewModel);
    func cardUnselected([CardViewModel]);
    func gameOver();
}

protocol ResolveMatchingCardsResultProtocol {
    func resolveMatchingCardsResult(result: CardsMatchingResult)
}

struct GameBoard {
   
    let columns: Int
    let rows: Int
    var board: [Card]
    
    var observers: [PGameBoardModelNotification]
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        self.board = [Card]()
        observers = [PGameBoardModelNotification]()
        
        populateGameBoardWithPairsOfCards()
    }

    subscript(column: Int, row: Int) -> Card {
        get {
            assert(indexIsValidForRow(column, row: row), "Index out of range")
            return board[(columns * row) + column]
        }
        set {
            assert(indexIsValidForRow(column, row: row), "Index out of range")
            board[(columns * row) + column] = newValue
        }
    }
    
    mutating func RegisterForNotification(observer: PGameBoardModelNotification) {
        observers.append(observer)
    }
    
    mutating func UnregisterForNotification(observer: PGameBoardModelNotification) {
        // TODO: implement
    }
    
    mutating private func populateGameBoardWithPairsOfCards() {
        var ct: CardType?
        var binome: Int = 0
        for c in 0..<self.rows {
            for r in 0..<self.columns {
                if ct == nil {
                    ct = CardType.getRandomCardType()
                }
                
                binome += 1
                
                board.append(Card(column: c, row: r, cardType: ct!))
                
                if binome == 2 {
                    ct = nil
                    binome = 0
                }
            }
        }
        
        // TODO: shuffle the Cards
    }
    
    func indexIsValidForRow(column: Int, row: Int) -> Bool {
        return column >= 0 && column < columns && row >= 0 && row < rows
    }
    
    func getDimensions() -> (columns: Int, rows: Int) {
        return (self.columns, self.rows)
    }
    
    mutating func doCardsMatch(columnFirstCard: Int, rowFirstCard: Int, columnSecondCard: Int, rowSecondCard: Int) -> CardsMatchingResult {
        let firstCardLocation = CardLocation(column: columnFirstCard, row: rowFirstCard)
        let secondCardLocation = CardLocation(column: columnSecondCard, row: rowSecondCard)
        
        let cardLocations = [firstCardLocation, secondCardLocation]
    
        if self[columnFirstCard, rowFirstCard].type == self[columnSecondCard, rowSecondCard].type {
            self[columnFirstCard, rowFirstCard] = Card(column: columnFirstCard, row: rowFirstCard, cardType: CardType.None)
            self[columnSecondCard, rowSecondCard] = Card(column: columnSecondCard, row: rowSecondCard, cardType: CardType.None)
            
            for cs in board {
                if cs.type != CardType.None {
                    return CardsMatchingResult(result: Result.DoMatch(false), cardLocations: cardLocations)
                }
            }
            return CardsMatchingResult(result: Result.DoMatch(true), cardLocations: cardLocations)
        }
        return CardsMatchingResult(result: Result.DontMatch, cardLocations: cardLocations)
    }

}