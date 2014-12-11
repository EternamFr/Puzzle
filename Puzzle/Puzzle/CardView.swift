//
//  CardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

class CardView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(title: String, position: CGPPoint, width: Int, height:Int) {
        super.init(frame:CGRectMake(position.x, position.y, width, height))
        
        backgroundColor = UIColor.blueColor()
        layer.cornerRadius = 0.1
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
}
