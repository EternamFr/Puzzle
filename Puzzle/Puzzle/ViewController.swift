//
//  ViewController.swift
//  Puzzle
//
//  Created by David Christy on 13/11/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CardViewTappedProtocol {

    @IBOutlet weak var LblDebug: UILabel!
    var gameEngine: GameEngine?
    var gameBoardView: GameBoardView?
    
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
        gameEngine = GameEngine()
        gameEngine?.setupNewGame(2, columns: 3)
        
        gameBoardView = GameBoardView(rows: 2, columns: 3, delegate: self)
        self.view.addSubview(gameBoardView!)
        
        self.spawnCardViews()
        
        //gameBoardView?.insertCard(1, column: 2, text: "(2,1) Lion")
        //gameBoardView?.insertCard(0, column: 0, text: "(0,0) Rhino")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func spawnCardViews() {
        let cardViewModels: [CardViewModel] = gameEngine!.getGameBoardCards()
        
        map(cardViewModels, {print("row: \($0.row) column: \($0.column)")})
        map(cardViewModels, {self.gameBoardView?.insertCard($0.row, column: $0.column, text: "(\($0.column),\($0.row)) \($0.cardSlot.getCardType())")})
    }
    
    func cardViewTapped(cardView: CardView, row: Int, column: Int) {
        gameEngine?.cardTapped(row, column: column)
    }
}

