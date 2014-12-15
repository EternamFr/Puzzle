//
//  CardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

protocol CardViewProtocol {
    func isTapped(cardView: CardView)
}

class CardView: UIView {
    
    var textLabel: UILabel
    let delegate: CardViewProtocol
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    init(text: String, position: CGPoint, width: CGFloat, height:CGFloat, delegate: CardViewProtocol) {
        textLabel = UILabel(frame: CGRectMake(0, 0, width, width))
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.text = text
        textLabel.textColor = UIColor.blackColor()
        textLabel.textAlignment = NSTextAlignment.Center
        
        self.delegate = delegate
        
        super.init(frame:CGRectMake(position.x, position.y, width, height))
        
        self.addSubview(textLabel)
        backgroundColor = UIColor.redColor()
        layer.cornerRadius = 0.4
        
        applyHoverShadow(self)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleCardTapped:"))
        self.addGestureRecognizer(tapRecognizer)
        self.userInteractionEnabled = true;
        self.exclusiveTouch = true;
    }

    func handleCardTapped(recognizer: UITapGestureRecognizer) {
        println("Tapped!!!")
        self.backgroundColor = UIColor.orangeColor()
        delegate.isTapped(self)
    }
    
    func applyPlainShadow(view: UIView) {
        var layer = view.layer
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }
    
    func applyHoverShadow(view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        
        var ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
        var path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
        
        var layer = view.layer
        layer.shadowPath = path.CGPath
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
}
