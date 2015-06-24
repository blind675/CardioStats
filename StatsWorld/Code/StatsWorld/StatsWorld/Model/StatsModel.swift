//
//  StatsModel.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 4/9/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import Foundation

class StatsModel {

    // this is actually a singleton
    static let statsBaseModel = StatsBaseModel.sharedInstance
    
    private static var index:Int = 0
    
    static var selectedIndex:Int {
        get {
            return index
        }
        set {
            if newValue < 0 || newValue > statsBaseModel.entryList.count {
                index = 0
            } else {
                index = newValue
            }
            currentlySelectedEntry = statsBaseModel.entryList[newValue]
        }
    }
    
    static var currentlySelectedEntry: StatsEntry? = statsBaseModel.entryList[0] {
        didSet {
            statsBaseModel.entryList[selectedIndex] = currentlySelectedEntry!
        }
    }
    
    static func numberOfEntryes() -> Int {
        return statsBaseModel.entryList.count
    }
    
    static func entryForIndex(index:Int) -> StatsEntry? {

        if index < 0 || index > numberOfEntryes() {
            return nil
        } else {
            return statsBaseModel.entryList[index]
        }
    }
    
    static func overallValue() -> Float {
        
        var value:Float = 0.0
        
        for element in statsBaseModel.entryList {
            value += element.currentValue
        }
        
        return value / Float(numberOfEntryes())
    }
    
    static func pointAdded() {
    
        if var entry = StatsModel.currentlySelectedEntry {

            // get today without time
            let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            let today = cal!.startOfDayForDate(NSDate())
            
            if today.compare(entry.lastTimeUpdated) != NSComparisonResult.OrderedSame {
                //check if the date of the entry is today
                
                // entry is a copy of the structure element in the array
                // i don't think this is the right pattern but i don't know no other for now
                entry.currentValue++
                entry.lastTimePointAdded = today
                entry.lastTimeUpdated = today
                StatsModel.currentlySelectedEntry = entry
                
                // update the date for all the entryes
                for (index, var entry) in enumerate(statsBaseModel.entryList) {
                    entry.lastTimeUpdated = today
                    statsBaseModel.entryList[index] = entry
                }
                
                NSUserDefaults.standardUserDefaults().setObject(today, forKey:kLastAddedDateKey)
                
                // save the plist
                StatsBaseModel.sharedInstance.saveEntryList()
            }
        }
    }
}


