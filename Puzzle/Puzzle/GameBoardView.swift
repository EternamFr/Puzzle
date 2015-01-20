//
//  GameBoardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

protocol GameBoardViewProtocol {
    func despawnCardView(column: Int, row: Int);
}

class GameBoardView: UIView, CardViewTappedProtocol {

    private let delegateCardTapped: CardViewTappedProtocol
    private let delegateCardFlipped: CardViewFlippedProtocol
    private var columns: Int
    private var rows: Int
    
    private var tileWidth: CGFloat
    private var tileHeight: CGFloat
    
    private var cardViews: Dictionary<Int, CardView>
    
    // TEST ANIM
    let tilePopStartScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.2
    let tilePopDelay: NSTimeInterval = 0.05
    let tileExpandTime: NSTimeInterval = 0.4 // 0.18
    let tileContractTime: NSTimeInterval = 0.4
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(columns: Int, rows: Int, delegateCardViewTapped: CardViewTappedProtocol, delegateCardViewFlipped: CardViewFlippedProtocol) {
        self.columns = columns
        self.rows = rows
        self.delegateCardTapped = delegateCardViewTapped
        self.delegateCardFlipped = delegateCardViewFlipped
        
        let b = UIScreen.mainScreen().bounds
        
        tileWidth = b.width / ((CGFloat(columns) * 2) + 1)
        tileHeight = b.height / ((CGFloat(rows) * 2) + 1)
        
        cardViews = Dictionary<Int, CardView>()
        
        super.init(frame: CGRectMake(0, 0, b.width, b.height))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func insertCard(column: Int, row: Int, text: String) {
        let tileX = (2 * (CGFloat(column) + 1.0) - 1.0) * tileWidth
        let tileY = (2 * (CGFloat(row) + 1.0) - 1.0) * tileHeight

        let cardView:CardView = CardView(text: text, position: CGPoint(x: tileX, y: tileY), width: tileWidth, height: tileHeight, column: column, row: row, delegate: self)

        cardViews[self.getCardViewId(column, row: row)] = cardView
        
        addSubview(cardView)
        
        bounce(cardView)
    }
    
    private func getCardViewId(column: Int, row: Int) -> Int {
        return column * 10 + row
    }
    
    func bounce(cardView: CardView) {
        UIView.animateWithDuration(tileExpandTime, delay: tilePopDelay, options: UIViewAnimationOptions.TransitionNone,
            animations: { () -> Void in
                // Make the tile 'pop'
                cardView.layer.setAffineTransform(CGAffineTransformMakeScale(self.tilePopMaxScale, self.tilePopMaxScale))
                //cardView.alpha = 0.5
            },
            completion: { (finished: Bool) -> Void in
                // Shrink the tile after it 'pops'
                UIView.animateWithDuration(self.tileContractTime, animations: { () -> Void in
                    cardView.layer.setAffineTransform(CGAffineTransformIdentity)
                    //cardView.alpha = 1.0
                })
        })
    }
    
    func flip(cardView: CardView, notifyToDelegate: Bool = true) {
        UIView.animateWithDuration(tileExpandTime, delay: tilePopDelay, options: UIViewAnimationOptions.TransitionNone,
            animations: { () -> Void in
                var rotationMatrix = CATransform3DMakeRotation(CGFloat(M_PI * 90.0 / 180.0), 0.0, 1.0, 0.0)
                cardView.layer.transform = rotationMatrix
            },
            completion: { (finished: Bool) -> Void in
                UIView.animateWithDuration(self.tileContractTime, animations: { () -> Void in
                    cardView.layer.transform = CATransform3DIdentity
                    }, completion: {(finished: Bool) -> Void in
                        if notifyToDelegate {
                            self.delegateCardFlipped.cardViewFlipped(cardView, column: cardView.column, row: cardView.row)
                        }
                })
        })
    }
    
    func despawn(cardView: CardView) {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
                cardView.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
                cardView.alpha = 0.0
            })
    }
    
    // CardViewTappedProtocol
    func cardViewTapped(cardView: CardView, column: Int, row: Int) {
        delegateCardTapped.cardViewTapped(cardView, column: column, row: row)
    }
    
    // TODO: add to protocol?
    func flipAndLockCardView(column: Int, row: Int) {
        let cardViewId = self.getCardViewId(column, row: row)
        if let cardView = self.cardViews[cardViewId] {
            cardView.userInteractionEnabled = false
            
            cardView.backgroundColor = UIColor.orangeColor()
            flip(cardView)
        } else {
            // TODO: what to do ?!?
        }
    }
    
    func unflipAndUnlockCardView(column: Int, row: Int) {
        let cardViewId = self.getCardViewId(column, row: row)
        if let cardView = self.cardViews[cardViewId] {
            cardView.userInteractionEnabled = true
            
            flip(cardView, notifyToDelegate: false)
            cardView.backgroundColor = UIColor.redColor()
        } else {
            // TODO: what to do ?!?
        }
    }
    
    func despawnCardView(column: Int, row: Int) {
        let cardViewId = self.getCardViewId(column, row: row)
        if let cardView = self.cardViews[cardViewId] {
            self.cardViews.removeValueForKey(cardViewId)
            
            despawn(cardView)
        } else {
            // TODO: what to do ?!?
        }
    }
    
}
