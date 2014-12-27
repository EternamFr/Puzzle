//
//  CardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

protocol CardViewTappedProtocol {
    func cardViewTapped(cardView: CardView, row: Int, column: Int)
}

class CardView: UIView {
    
    var textLabel: UILabel
    let row: Int
    let column: Int
    let delegateCardViewTapped: CardViewTappedProtocol
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    init(text: String, position: CGPoint, width: CGFloat, height:CGFloat, row: Int, column:Int, delegate: CardViewTappedProtocol) {
        textLabel = UILabel(frame: CGRectMake(0, 0, width, width))
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.text = text
        textLabel.textColor = UIColor.blackColor()
        textLabel.textAlignment = NSTextAlignment.Center
        
        self.row = row
        self.column = column
        
        self.delegateCardViewTapped = delegate
        
        super.init(frame:CGRectMake(position.x, position.y, width, height))
        
        self.addSubview(textLabel)
        backgroundColor = UIColor.redColor()
        layer.cornerRadius = 0.4
        
        applyHoverShadow(self)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleCardViewTapped:"))
        self.addGestureRecognizer(tapRecognizer)
        self.userInteractionEnabled = true;
        self.exclusiveTouch = true;
    }

    func handleCardViewTapped(recognizer: UITapGestureRecognizer) {
        println(self.textLabel.text! + " tapped!!!")
        self.backgroundColor = UIColor.orangeColor()
        delegateCardViewTapped.cardViewTapped(self,row: row, column: column)
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
