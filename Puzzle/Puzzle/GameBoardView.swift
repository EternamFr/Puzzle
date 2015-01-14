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

    private let delegate: CardViewTappedProtocol
    
    private var columns: Int
    private var rows: Int
    
    private var tileWidth: CGFloat
    private var tileHeight: CGFloat
    
    private var cardViews: Dictionary<Int, CardView>
    
    // TEST ANIM
    let tilePopStartScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.1
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
    init(columns: Int, rows: Int, delegate: CardViewTappedProtocol) {
        self.columns = columns
        self.rows = rows
        self.delegate = delegate
        
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

        cardViews[column * 10 + row] = cardView
        
        addSubview(cardView)
        
        bounce(cardView)
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
    
    func flip(cardView: CardView) {
        UIView.animateWithDuration(tileExpandTime, delay: tilePopDelay, options: UIViewAnimationOptions.TransitionNone,
            animations: { () -> Void in
                var rotationMatrix = CATransform3DMakeRotation(CGFloat(M_PI * 90.0 / 180.0), 0.0, 1.0, 0.0)
                cardView.layer.transform = rotationMatrix
            },
            completion: { (finished: Bool) -> Void in
                // Shrink the tile after it 'pops'
                UIView.animateWithDuration(self.tileContractTime, animations: { () -> Void in
                    cardView.layer.transform = CATransform3DIdentity
                })
        })
    }
    
    // CardViewTappedProtocol
    func cardViewTapped(cardView: CardView, column: Int, row: Int) {
        flip(cardView)
        
        delegate.cardViewTapped(cardView, column: column, row: row)
    }
    
}
