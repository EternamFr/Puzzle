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
            drawCanvas1(rect)
            
        case .Donkey:
            let pathRect = CGRectInset(rect, rect.width * 0.2, rect.height * 0.2)
            let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 2.0)
            
            UIColor.redColor().setFill()
            UIColor.whiteColor().setStroke()
            
            path.fill()
            path.stroke()
        case .Lion:
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
    
    func drawCanvas1(frame: CGRect) {
        //// Color Declarations
        let color = UIColor(red: 0.159, green: 0.531, blue: 0.786, alpha: 1.000)
        let color2 = UIColor(red: 0.957, green: 0.600, blue: 0.017, alpha: 1.000)
        let color3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let color4 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        
        
        //// Subframes
        let group: CGRect = CGRectMake(frame.minX + 8.5, frame.minY + 7, frame.width - 17.5, frame.height - 12)
        
        
        //// Group
        //// Oval Drawing
        let ovalPath = UIBezierPath()
        ovalPath.moveToPoint(CGPointMake(group.minX + 0.44599 * group.width, group.minY + 0.34066 * group.height))
        ovalPath.addCurveToPoint(CGPointMake(group.minX + 0.30749 * group.width, group.minY + 0.06593 * group.height), controlPoint1: CGPointMake(group.minX + 0.44599 * group.width, group.minY + 0.18893 * group.height), controlPoint2: CGPointMake(group.minX + 0.38398 * group.width, group.minY + 0.06593 * group.height))
        ovalPath.addCurveToPoint(CGPointMake(group.minX + 0.16899 * group.width, group.minY + 0.34066 * group.height), controlPoint1: CGPointMake(group.minX + 0.23100 * group.width, group.minY + 0.06593 * group.height), controlPoint2: CGPointMake(group.minX + 0.16899 * group.width, group.minY + 0.18893 * group.height))
        ovalPath.addCurveToPoint(CGPointMake(group.minX + 0.30749 * group.width, group.minY + 0.61538 * group.height), controlPoint1: CGPointMake(group.minX + 0.16899 * group.width, group.minY + 0.49239 * group.height), controlPoint2: CGPointMake(group.minX + 0.23100 * group.width, group.minY + 0.61538 * group.height))
        ovalPath.addCurveToPoint(CGPointMake(group.minX + 0.44599 * group.width, group.minY + 0.34066 * group.height), controlPoint1: CGPointMake(group.minX + 0.38398 * group.width, group.minY + 0.61538 * group.height), controlPoint2: CGPointMake(group.minX + 0.44599 * group.width, group.minY + 0.49239 * group.height))
        ovalPath.closePath()
        color.setFill()
        ovalPath.fill()
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath()
        oval2Path.moveToPoint(CGPointMake(group.minX + 0.81956 * group.width, group.minY + 0.57216 * group.height))
        oval2Path.addCurveToPoint(CGPointMake(group.minX + 0.81956 * group.width, group.minY + 0.09817 * group.height), controlPoint1: CGPointMake(group.minX + 0.90502 * group.width, group.minY + 0.44127 * group.height), controlPoint2: CGPointMake(group.minX + 0.90502 * group.width, group.minY + 0.22906 * group.height))
        oval2Path.addCurveToPoint(CGPointMake(group.minX + 0.51009 * group.width, group.minY + 0.09817 * group.height), controlPoint1: CGPointMake(group.minX + 0.73410 * group.width, group.minY + -0.03272 * group.height), controlPoint2: CGPointMake(group.minX + 0.59555 * group.width, group.minY + -0.03272 * group.height))
        oval2Path.addCurveToPoint(CGPointMake(group.minX + 0.51009 * group.width, group.minY + 0.57216 * group.height), controlPoint1: CGPointMake(group.minX + 0.42463 * group.width, group.minY + 0.22906 * group.height), controlPoint2: CGPointMake(group.minX + 0.42463 * group.width, group.minY + 0.44127 * group.height))
        oval2Path.addCurveToPoint(CGPointMake(group.minX + 0.81956 * group.width, group.minY + 0.57216 * group.height), controlPoint1: CGPointMake(group.minX + 0.59555 * group.width, group.minY + 0.70305 * group.height), controlPoint2: CGPointMake(group.minX + 0.73410 * group.width, group.minY + 0.70305 * group.height))
        oval2Path.closePath()
        color.setFill()
        oval2Path.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.moveToPoint(CGPointMake(group.minX + 0.32411 * group.width, group.minY + 0.07039 * group.height))
        bezier2Path.addCurveToPoint(CGPointMake(group.minX + 0.41029 * group.width, group.minY + 0.18681 * group.height), controlPoint1: CGPointMake(group.minX + 0.53274 * group.width, group.minY + 0.03864 * group.height), controlPoint2: CGPointMake(group.minX + 0.41029 * group.width, group.minY + 0.18681 * group.height))
        color.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.moveToPoint(CGPointMake(group.minX + 0.88366 * group.width, group.minY + 0.31729 * group.height))
        bezier3Path.addCurveToPoint(CGPointMake(group.minX + 1.00000 * group.width, group.minY + 0.41354 * group.height), controlPoint1: CGPointMake(group.minX + 0.88366 * group.width, group.minY + 0.31729 * group.height), controlPoint2: CGPointMake(group.minX + 1.00000 * group.width, group.minY + 0.06703 * group.height))
        bezier3Path.addCurveToPoint(CGPointMake(group.minX + 0.81164 * group.width, group.minY + 0.61568 * group.height), controlPoint1: CGPointMake(group.minX + 1.00000 * group.width, group.minY + 0.76006 * group.height), controlPoint2: CGPointMake(group.minX + 0.81164 * group.width, group.minY + 0.73118 * group.height))
        bezier3Path.addCurveToPoint(CGPointMake(group.minX + 0.61774 * group.width, group.minY + 0.92369 * group.height), controlPoint1: CGPointMake(group.minX + 0.81164 * group.width, group.minY + 0.50017 * group.height), controlPoint2: CGPointMake(group.minX + 0.76178 * group.width, group.minY + 1.23170 * group.height))
        bezier3Path.addCurveToPoint(CGPointMake(group.minX + 0.45707 * group.width, group.minY + 0.61568 * group.height), controlPoint1: CGPointMake(group.minX + 0.47369 * group.width, group.minY + 0.61568 * group.height), controlPoint2: CGPointMake(group.minX + 0.24101 * group.width, group.minY + 0.91406 * group.height))
        color.setFill()
        bezier3Path.fill()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPointMake(group.minX + 0.17176 * group.width, group.minY + 0.22527 * group.height))
        bezierPath.addCurveToPoint(CGPointMake(group.minX + 0.00002 * group.width, group.minY + 0.68681 * group.height), controlPoint1: CGPointMake(group.minX + -0.00552 * group.width, group.minY + 0.39011 * group.height), controlPoint2: CGPointMake(group.minX + 0.00002 * group.width, group.minY + 0.68681 * group.height))
        bezierPath.addCurveToPoint(CGPointMake(group.minX + 0.17176 * group.width, group.minY + 0.45604 * group.height), controlPoint1: CGPointMake(group.minX + 0.00002 * group.width, group.minY + 0.68681 * group.height), controlPoint2: CGPointMake(group.minX + 0.11636 * group.width, group.minY + 0.37912 * group.height))
        color2.setFill()
        bezierPath.fill()
        UIColor.blackColor().setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.moveToPoint(CGPointMake(group.minX + 0.17176 * group.width, group.minY + 0.45604 * group.height))
        bezier4Path.addLineToPoint(CGPointMake(group.minX + 0.17176 * group.width, group.minY + 0.22527 * group.height))
        color2.setFill()
        bezier4Path.fill()
        UIColor.blackColor().setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()
        
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalInRect: CGRectMake(group.minX + floor(group.width * 0.22135 - 0) + 0.5, group.minY + floor(group.height * 0.18478 + 0.5), floor(group.width * 0.28001 - 0) - floor(group.width * 0.22135 - 0), floor(group.height * 0.30435 + 0.5) - floor(group.height * 0.18478 + 0.5)))
        color3.setFill()
        oval3Path.fill()
        
        
        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalInRect: CGRectMake(group.minX + floor(group.width * 0.22401 + 0.5) + 0, group.minY + floor(group.height * 0.22283) + 0.5, floor(group.width * 0.26135 + 0.5) - floor(group.width * 0.22401 + 0.5), floor(group.height * 0.29891) - floor(group.height * 0.22283)))
        color4.setFill()
        oval4Path.fill()
        color3.setStroke()
        oval4Path.lineWidth = 1
        oval4Path.stroke()
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