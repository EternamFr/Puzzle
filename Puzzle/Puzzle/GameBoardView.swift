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
    
    private var tileWidth: Int
    private var tileHeight: Int
    
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
        
        tileWidth = CInt(b.width / ((dimensionX * 2) + 1))
        tileHeight = CInt(b.height / ((dimensionY * 2) + 1))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    func insertCard(row: Int, column: Int, cardType: CardType) {
        var cardView:CardView(row, column, cardType)
    }
    
}
