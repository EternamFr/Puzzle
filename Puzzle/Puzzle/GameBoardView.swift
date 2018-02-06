//
//  GameBoardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

protocol GameBoardViewProtocol {
    func despawnCardView(_ column: Int, row: Int);
}

class GameBoardView: UIView, CardViewTappedProtocol {

    private let delegateCardViewProtocols: CardViewProtocols
    private var columns: Int
    private var rows: Int
    
    private var tileWidth: CGFloat
    private var tileHeight: CGFloat
    
    private var cardViews: Dictionary<Int, CardView>
    
    // TEST ANIM
    let tilePopStartScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.2
    let tilePopDelay: TimeInterval = 0.05
    let tileExpandTime: TimeInterval = 0.4 // 0.18
    let tileContractTime: TimeInterval = 0.4
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(columns: Int, rows: Int, delegateCardViewProtocols: CardViewProtocols) {
        self.columns = columns
        self.rows = rows
        self.delegateCardViewProtocols = delegateCardViewProtocols
        
        let b = UIScreen.main.bounds
        
        tileWidth = b.width / ((CGFloat(columns) * 2) + 1)
        tileHeight = b.height / ((CGFloat(rows) * 2) + 1)
        
        cardViews = Dictionary<Int, CardView>()
        
        super.init(frame: CGRect(x: 0, y: 0, width: b.width, height: b.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func insertCard(_ column: Int, row: Int, cardType: CardType) {
        let tileX = (2 * (CGFloat(column) + 1.0) - 1.0) * tileWidth
        let tileY = (2 * (CGFloat(row) + 1.0) - 1.0) * tileHeight

        let cardView:CardView = CardView(cardType: cardType, position: CGPoint(x: tileX, y: tileY), width: tileWidth, height: tileHeight, column: column, row: row, delegate: self, id: self.getCardViewId(column, row: row))

        cardViews[self.getCardViewId(column, row: row)] = cardView
        
        addSubview(cardView)
        
        let delay = Randomizer.getRandomDouble(10) / 10.0
        bounce(cardView, delay: delay)
    }
    
    private func getCardViewId(_ column: Int, row: Int) -> Int {
        return column * 10 + row
    }
    
    // ------------------------ Animations ------------------------
    func bounce(_ cardView: CardView, delay: TimeInterval) {
        UIView.animate(withDuration: tileExpandTime, delay: delay, options: UIViewAnimationOptions(),
            animations: { () -> Void in
                cardView.layer.setAffineTransform(CGAffineTransform(scaleX: self.tilePopMaxScale, y: self.tilePopMaxScale))
                cardView.alpha = 0.5
            },
            completion: { (finished: Bool) -> Void in
                UIView.animate(withDuration: self.tileContractTime, animations: { () -> Void in
                    cardView.layer.setAffineTransform(CGAffineTransform.identity)
                    cardView.alpha = 1.0
                })
        })
    }
    
    func flip(_ cardView: CardView, notifyToDelegate: Bool = true) {
        UIView.animate(withDuration: tileExpandTime, delay: tilePopDelay, options: UIViewAnimationOptions(),
            animations: { () -> Void in
                let rotationMatrix = CATransform3DMakeRotation(CGFloat(.pi * 90.0 / 180.0), 0.0, 1.0, 0.0)
                cardView.layer.transform = rotationMatrix
            },
            completion: { (finished: Bool) -> Void in
                print("switch now!!!")
                UIView.animate(withDuration: self.tileContractTime, animations: { () -> Void in
                    cardView.layer.transform = CATransform3DIdentity
                    }, completion: {(finished: Bool) -> Void in
                        if notifyToDelegate {
                            self.delegateCardViewProtocols.cardViewFlipped(cardView, column: cardView.column, row: cardView.row)
                        }
                })
        })
    }
    
    func despawn(_ cardView: CardView) {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
                cardView.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
                cardView.alpha = 0.0
            }, completion: {(finished: Bool) -> Void in
                self.cardViews.removeValue(forKey: cardView.id)
                self.delegateCardViewProtocols.cardViewDespawned(cardView, column: cardView.column, row: cardView.row, last: self.cardViews.count == 0)
                cardView.removeFromSuperview()
        })
    }
    
    // CardViewTappedProtocol
    func cardViewTapped(_ cardView: CardView, column: Int, row: Int) {
        self.delegateCardViewProtocols.cardViewTapped(cardView, column: column, row: row)
    }
    
    func flipAndLockCardView(_ column: Int, row: Int) {
        let cardViewId = self.getCardViewId(column, row: row)
        if let cardView = self.cardViews[cardViewId] {
            cardView.isUserInteractionEnabled = false
            
            cardView.backgroundColor = UIColor.orange
            flip(cardView)
        } else {
            // TODO: what to do ?!?
        }
    }
    
    func unflipAndUnlockCardView(_ column: Int, row: Int) {
        let cardViewId = self.getCardViewId(column, row: row)
        if let cardView = self.cardViews[cardViewId] {
            cardView.isUserInteractionEnabled = true
            
            flip(cardView, notifyToDelegate: false)
            cardView.backgroundColor = UIColor.red
        } else {
            // TODO: what to do ?!?
        }
    }
    
    func despawnCardView(_ column: Int, row: Int) {
        let cardViewId = self.getCardViewId(column, row: row)
        if let cardView = self.cardViews[cardViewId] {
            despawn(cardView)
        } else {
            // TODO: what to do ?!?
        }
    }
    
}
