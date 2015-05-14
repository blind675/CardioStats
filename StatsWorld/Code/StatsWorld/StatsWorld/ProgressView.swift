//
//  ProgressView.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 4/10/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressView: UIView {

    @IBInspectable
    var maxValue:Float {
        get {
            return maxEntryValue
        }
        set {
            maxEntryValue = newValue
        }
    }
    @IBInspectable
    var currentValue:Float = 20.0 {
        didSet {
            if currentValue < 0 {
                currentValue = 0
            }
            if currentValue > maxValue {
                currentValue = maxValue
            }
            
            setNeedsDisplay()
        }
    }

    var currentColor:UIColor = UIColor.blueColor()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        // draw background gradient
        let locations: [CGFloat] = [ 0.0,1.0]
        
        let colors = [UIColor.redColor().CGColor,
            UIColor.greenColor().CGColor]
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradientCreateWithColors(colorspace,
            colors, locations)
        
        var startPoint = CGPoint()
        var endPoint =  CGPoint()
        
        startPoint.x = 0.0
        startPoint.y = rect.height
        endPoint.x = rect.width
        endPoint.y = rect.height
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        
        // draw top triangle
        CGContextMoveToPoint(context, 0, rect.height)
        CGContextAddLineToPoint(context, rect.width , 0)
        CGContextAddLineToPoint(context, 0, 0 )
        CGContextAddLineToPoint(context, 0, rect.height )

        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        
        CGContextFillPath(context)
        
        // draw indicator line
        CGContextSetLineWidth(context, 2.0)
        
        // find the line location
        var pointValue:CGFloat = 0
        
        if currentValue != 0 {
            pointValue = CGFloat( currentValue / maxEntryValue )
        }
        
        let pointPosition = rect.width * pointValue
        
        CGContextMoveToPoint(context, pointPosition, rect.height)
        CGContextAddLineToPoint(context, pointPosition , 0)
        
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        
        CGContextStrokePath(context)
    }
    
}
