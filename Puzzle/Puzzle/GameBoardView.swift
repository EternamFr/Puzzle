//
//  GameBoardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

class GameBoardView: UIView {

    private var dimensionX: Int
    private var dimensionY: Int
    
    private var tileWidth: CGFloat
    private var tileHeight: CGFloat
    
    // TEST ANIM
    let tilePopStartScale: CGFloat = 0.1
    let tilePopMaxScale: CGFloat = 1.1
    let tilePopDelay: NSTimeInterval = 0.05
    let tileExpandTime: NSTimeInterval = 0.18
    let tileContractTime: NSTimeInterval = 0.08
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(dimensionX dX: Int, dimensionY dY: Int) {
        dimensionX = dX
        dimensionY = dY
        
        let b = UIScreen.mainScreen().bounds
        
        tileWidth = b.width / ((CGFloat(dimensionX) * 2) + 1)
        tileHeight = b.height / ((CGFloat(dimensionY) * 2) + 1)
        
        super.init(frame: CGRectMake(0, 0, b.width, b.height))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func insertCard(row: Int, column: Int, text: String) {
        let tileX = (2 * (CGFloat(column) + 1.0) - 1.0) * tileWidth
        let tileY = (2 * (CGFloat(row) + 1.0) - 1.0) * tileHeight

        let cardView:CardView = CardView(text: text, position: CGPoint(x: tileX, y: tileY), width: tileWidth, height: tileHeight)
        addSubview(cardView)
        
        UIView.animateWithDuration(tileExpandTime, delay: tilePopDelay, options: UIViewAnimationOptions.TransitionNone,
            animations: { () -> Void in
                // Make the tile 'pop'
                cardView.layer.setAffineTransform(CGAffineTransformMakeScale(self.tilePopMaxScale, self.tilePopMaxScale))
            },
            completion: { (finished: Bool) -> Void in
                // Shrink the tile after it 'pops'
                UIView.animateWithDuration(self.tileContractTime, animations: { () -> Void in
                    cardView.layer.setAffineTransform(CGAffineTransformIdentity)
                })
        })
    }
    
}
