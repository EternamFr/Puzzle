//
//  ViewController.swift
//  Puzzle
//
//  Created by David Christy on 13/11/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardViewTappedProtocol, CardViewFlippedProtocol, ResolveMatchingCardsResultProtocol {

    @IBOutlet weak var LblDebug: UILabel!
    private var gameBoardView: GameBoardView?
    private var gameBoard: GameBoard?
    private var firstCardFlipped: CardLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        var v = UIView(frame: CGRectMake(50, 50, 150, 150))
        v.backgroundColor = UIColor.blueColor()
        v.layer.cornerRadius = 10.0
        v.layer.masksToBounds = true
        v.layer.borderWidth = 4.0
        v.layer.borderColor = UIColor.redColor().CGColor
        self.view.addSubview(v)
        
        let b = UIScreen.mainScreen().bounds
        
        //
        self.setupNewGame(3, rows: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // TODO: add cards'theme as parameter
    func setupNewGame(columns: Int, rows: Int){
        gameBoard = GameBoard(columns: columns, rows: rows)
        
        gameBoardView = GameBoardView(columns: columns, rows: rows, delegateCardViewTapped: self, delegateCardViewFlipped: self)
        self.view.addSubview(gameBoardView!)
        
        self.spawnCardViews()
    }
    
    func spawnCardViews() {
        let cardViewModels: [CardViewModel] = self.getGameBoardCards()
        
        map(cardViewModels, {self.gameBoardView?.insertCard($0.column, row: $0.row, text: "(\($0.column),\($0.row)) \($0.type.simpleDescription())")})
    }

    func getGameBoardCards() -> [CardViewModel] {
        let board = gameBoard?.board
        let (columns, rows) = gameBoard!.getDimensions()
        
        let indexes = map(0..<gameBoard!.board.count, { $0 })
        
        let viewModels = indexes.map{CardViewModel(column: $0 % columns,row: $0 / columns, type: board![$0].type)}
        return viewModels
    }
    
    // CardViewTappedProtocol
    func cardViewTapped(cardView: CardView, column: Int, row: Int) {
        self.gameBoardView?.flipAndLockCardView(column, row: row)
    }
    
    // CardViewFlippedProtocol
    func cardViewFlipped(cardView: CardView, column: Int, row: Int) {
        if self.firstCardFlipped? == nil {
            firstCardFlipped = CardLocation(column: column, row: row)
        } else {
            let r = gameBoard?.doCardsMatch(firstCardFlipped!, second: CardLocation(column: column, row: row))
            firstCardFlipped = nil
            self.resolveMatchingCardsResult(r!)
        }
    }
    
    // ResolveMatchingCardsResultProtocol
    func resolveMatchingCardsResult(result: CardsMatchingResult) {
            switch result.result {
            case .DontMatch:
                println("Dont match")
                
                result.cardLocations.map{self.gameBoardView?.unflipAndUnlockCardView($0.column, row: $0.row)}
            case .DoMatch(false):
                println("Match, but game goes on!")
                
                result.cardLocations.map{self.gameBoardView?.despawnCardView($0.column, row: $0.row)}
            case .DoMatch(true):
                println("Match... and game over!")
                
                result.cardLocations.map{self.gameBoardView?.despawnCardView($0.column, row: $0.row)}                
            default:
                println("What could that be ?!?")
        }
    }
}

