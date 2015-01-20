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
        let types = CardType.getRandomCardTypes(rows*columns)
        
        let indexes = map(0..<columns * rows, {$0})
        indexes.map{self.board.append(Card(column: $0 % self.columns, row: $0 / self.columns, cardType: types[$0]))}
    }
    
    func indexIsValidForRow(column: Int, row: Int) -> Bool {
        return column >= 0 && column < columns && row >= 0 && row < rows
    }
    
    func getDimensions() -> (columns: Int, rows: Int) {
        return (self.columns, self.rows)
    }
    
    mutating func doCardsMatch(first: CardLocation, second: CardLocation) -> CardsMatchingResult {
        let cardLocations = [first, second]
    
        if self[first.column, first.row].type == self[second.column, second.row].type {
            self[first.column, first.row] = Card(column: first.column, row: first.row, cardType: CardType.None)
            self[second.column, second.row] = Card(column: second.column, row: second.row, cardType: CardType.None)
            
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