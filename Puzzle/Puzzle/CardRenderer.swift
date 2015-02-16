//
//  CardRenderer.swift
//  Puzzle
//
//  Created by David Christy on 08/02/2015.
//  Copyright (c) 2015 David Christy. All rights reserved.
//

import Foundation
import UIKit

class ThemeRenderer {

    func RenderCardType(rect: CGRect, cardType: CardType) {
        switch cardType {
        case .Crocodile:
            let pathRect = CGRectInset(rect, rect.width * 0.2, rect.height * 0.2)
            let path = UIBezierPath(ovalInRect: pathRect)
            
            UIColor.blueColor().setFill()
            UIColor.whiteColor().setStroke()
            
            path.fill()
            path.stroke()
        case .Donkey:
            let pathRect = CGRectInset(rect, rect.width * 0.2, rect.height * 0.2)
            let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 2.0)
            
            UIColor.redColor().setFill()
            UIColor.whiteColor().setStroke()
            
            path.fill()
            path.stroke()
        case .Lion:
            let pathRect = CGRectInset(rect, rect.width * 0.2, rect.height * 0.2)
            let path = UIBezierPath(arcCenter: CGPointMake(rect.midX, rect.midY), radius: 30.0, startAngle: 0.0, endAngle: 3.1415, clockwise: true)

            UIColor.orangeColor().setFill()
            UIColor.whiteColor().setStroke()
            
            path.fill()
            path.stroke()
        default:
            let pathRect = CGRectInset(rect, rect.width * 0.2, rect.height * 0.2)
            let path = UIBezierPath(ovalInRect: pathRect)
            
            UIColor.greenColor().setFill()
            UIColor.whiteColor().setStroke()
            
            path.fill()
            path.stroke()
        }
    }
    
    func RenderCardBackType(rect: CGRect, cardBackType: CardBackType) {
        let pathRect = CGRectInset(rect, rect.width * 0.2, rect.height * 0.2)
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 2.0)
        
        UIColor.whiteColor().setFill()
        UIColor.yellowColor().setStroke()
        
        path.fill()
        path.stroke()
    }
    
}