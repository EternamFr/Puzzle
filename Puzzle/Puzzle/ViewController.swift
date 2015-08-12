//
//  ViewController.swift
//  Puzzle
//
//  Created by David Christy on 13/11/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, CardViewProtocols, ResolveMatchingCardsResultProtocol {

    @IBOutlet weak var BtStart: UIButton!
    @IBOutlet weak var LblDebug: UILabel!
    
    private var gameBoardView: GameBoardView?
    private var gameBoard: GameBoard?
    private var firstCardFlipped: CardLocation?
    private var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btStartGame(sender: UIButton) {
        LblDebug.text = ""
        BtStart.hidden = true
        self.setupNewGame(3, rows: 2)
    }
    
    // TODO: add cards'theme as parameter
    func setupNewGame(columns: Int, rows: Int){
        gameBoard = GameBoard(columns: columns, rows: rows)
        
        gameBoardView = GameBoardView(columns: columns, rows: rows, delegateCardViewProtocols: self)
        self.view.addSubview(gameBoardView!)
        
        self.spawnCardViews()
    }
    
    func cleanOldGame() {
        self.gameBoard = nil
        self.gameBoardView?.removeFromSuperview()
        self.gameBoardView = nil
        
        LblDebug.text = "Well done!"
        BtStart.hidden = false
    }
    
    func spawnCardViews() {
        let cardViewModels: [CardViewModel] = self.getGameBoardCards()
        
        cardViewModels.map({self.gameBoardView?.insertCard($0.column, row: $0.row, cardType: $0.type)})
    }

    func getGameBoardCards() -> [CardViewModel] {
        let board = gameBoard?.board
        let (columns, _) = gameBoard!.getDimensions()
        
        let indexes = (0..<gameBoard!.board.count).map({ $0 })
        
        let viewModels = indexes.map{CardViewModel(column: $0 % columns,row: $0 / columns, type: board![$0].type)}
        return viewModels
    }
    
    // ----------------------------- CardViewProtocols -----------------------------
    func cardViewTapped(cardView: CardView, column: Int, row: Int) {
        self.gameBoardView?.flipAndLockCardView(column, row: row)
        
        // TODO: Play sound associated to the card ?!?
        let soundURL = NSBundle.mainBundle().URLForResource("flip", withExtension: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: soundURL!)
            audioPlayer.play()
        } catch _ {
        }
        
    }
    
    func cardViewFlipped(cardView: CardView, column: Int, row: Int) {
        if self.firstCardFlipped == nil {
            firstCardFlipped = CardLocation(column: column, row: row)
        } else {
            let r = gameBoard?.doCardsMatch(firstCardFlipped!, second: CardLocation(column: column, row: row))
            firstCardFlipped = nil
            self.resolveMatchingCardsResult(r!)
        }
    }
    
    func cardViewDespawned(cardView: CardView, column: Int, row: Int, last: Bool) {
        if last == true {
            self.cleanOldGame()
        }
    }
    
    // ----------------------------- ResolveMatchingCardsResultProtocol -----------------------------
    func resolveMatchingCardsResult(result: CardsMatchingResult) {
        switch result.result {
            case .DontMatch:
                result.cardLocations.map{self.gameBoardView?.unflipAndUnlockCardView($0.column, row: $0.row)}
                
            case .DoMatch(false):
                result.cardLocations.map{self.gameBoardView?.despawnCardView($0.column, row: $0.row)}
                
            case .DoMatch(true):
                result.cardLocations.map{self.gameBoardView?.despawnCardView($0.column, row: $0.row)}
        }
    }
    
}

