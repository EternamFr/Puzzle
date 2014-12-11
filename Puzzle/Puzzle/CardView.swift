//
//  CardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

class CardView: UIView {

    var textLabel: UILabel
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    init(text: String, position: CGPoint, width: CGFloat, height:CGFloat) {
        textLabel = UILabel(frame: CGRectMake(0, 0, width, width))
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.text = text
        textLabel.textColor = UIColor.blackColor()
        textLabel.textAlignment = NSTextAlignment.Center
        
        super.init(frame:CGRectMake(position.x, position.y, width, height))
        
        self.addSubview(textLabel)
        backgroundColor = UIColor.redColor()
        layer.cornerRadius = 0.1
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
}
