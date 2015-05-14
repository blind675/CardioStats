//
//  Tool.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 4/11/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

// Global constants
var maxEntryValue:Float = 100
let kLastAddedDateKey = "lastAddedDate"

class Tool {
    
    static func colorForValue(value:Float) -> UIColor {
    
        // find the color
        var colorValue:CGFloat = 0
        
        if value != 0 {
            colorValue = CGFloat(( value / maxEntryValue) * 2)
        }
        
        if colorValue <= 1 {
            
            let colorDistance = 255 * colorValue
            
            return UIColor(red: 1, green: colorValue, blue: 0.0, alpha: 1.0)
            
        } else {
            
            let colorDistance = Int(255 * (colorValue - 1))
            
            return UIColor(red:  (1 - (colorValue - 1)), green: 1, blue: 0.0, alpha: 1.0)
        }
    }
    
}