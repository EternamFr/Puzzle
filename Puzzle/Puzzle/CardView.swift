//
//  CardView.swift
//  Puzzle
//
//  Created by David Christy on 11/12/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

protocol CardViewProtocols: CardViewTappedProtocol, CardViewFlippedProtocol, CardViewDespawnedProtocol {}
    
protocol CardViewTappedProtocol {
    func cardViewTapped(_ cardView: CardView, column: Int, row: Int);
}

protocol CardViewFlippedProtocol {
    func cardViewFlipped(_ cardView: CardView, column: Int, row: Int);
}

protocol CardViewDespawnedProtocol {
    func cardViewDespawned(_ cardView: CardView, column: Int, row: Int, last: Bool);
}

class CardView: UIView {
    
//    var textLabel: UILabel
    let column: Int
    let row: Int
    let id: Int
    let cardType: CardType
    let delegateCardViewTapped: CardViewTappedProtocol
    
    // Only override drawRect: if you perform custom drawing.
    override func draw(_ rect: CGRect) {
        // Drawing code
//        let pathRect = CGRectInset(rect, rect.width * 0.2, rect.height * 0.2)
//        let path = UIBezierPath(ovalInRect: pathRect)
//        
//        UIColor.blueColor().setFill()
//        UIColor.whiteColor().setStroke()
//        
//        path.fill()
//        path.stroke()
        let renderer = ThemeRenderer()
        renderer.RenderCardType(rect, cardType: self.cardType)
    }
    
    init(cardType: CardType, position: CGPoint, width: CGFloat, height:CGFloat, column:Int, row: Int, delegate: CardViewTappedProtocol, id: Int) {
        self.column = column
        self.row = row
        self.cardType = cardType
        self.delegateCardViewTapped = delegate
        self.id = id
        
        super.init(frame:CGRect(x: position.x, y: position.y, width: width, height: height))
        
        applyPlainShadow(self)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(CardView.handleCardViewTapped(_:)))
        self.addGestureRecognizer(tapRecognizer)
        self.isUserInteractionEnabled = true;
        self.isExclusiveTouch = true;
        
        self.alpha = 0.0
    }

    @objc func handleCardViewTapped(_ recognizer: UITapGestureRecognizer) {
//        println(self.textLabel.text! + " tapped!!!")
        delegateCardViewTapped.cardViewTapped(self, column: column, row: row)
    }
    
    func applyPlainShadow(_ view: UIView) {
        let layer = view.layer
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
    }
    
    func applyHoverShadow(_ view: UIView) {
        let size = view.bounds.size
        let width = size.width
        let height = size.height
        
        let ovalRect = CGRect(x: 5, y: height + 5, width: width - 10, height: 15)
        let path = UIBezierPath(roundedRect: ovalRect, cornerRadius: 10)
        
        let layer = view.layer
        layer.shadowPath = path.cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
}
