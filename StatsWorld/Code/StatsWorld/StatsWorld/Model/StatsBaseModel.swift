//
//  StatsBaseModel.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 4/3/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import UIKit

struct StatsEntry: Printable {
   
    var name = ""
    var entryDescription:String?
    var currentValue:Float
    var speedStartValue:Float?
    var speedNeedeForNextPoint:Float {
        get {
            
            let speedStart = speedStartValue ?? 0.0
            let speedReset = speedResetInterval ?? 101.0
            let speedIncrease = speedIncreaseValue ?? 0.0
            let speedIncreasePoint = speedIncreaseAtPoints ?? 1.0
            let resetFlag:Float = (currentValue % speedReset) > 0 ? 1.0 : 0.0
            
            // println("\(speedStart) + ( \(resetFlag) * \(speedIncrease) * \(Float(Int((currentValue / speedIncreasePoint) % speedReset))))")
            
            return speedStart + (resetFlag * speedIncrease * Float(Int((currentValue / speedIncreasePoint) % speedReset)))
        }
    }
    
    var speedIncreaseValue:Float?
    var speedIncreaseAtPoints:Float?
    var speedResetInterval:Float?
    var timeStartValue:Float
    var timeNeededForNextPoint:Int {
        get {
            let timeStart = timeStartValue ?? 0.0
            let timeReset = timeResetInterval ?? 101.0
            let timeIncrease = timeIncreaseValue ?? 0.0
            let timeIncreasePoint = timeIncreaseAtPoints ?? 1.0
            let resetFlag:Float = (currentValue % timeReset) > 0 ? 1.0 : 0.0
            
            // println("\(timeStart) + ( \(resetFlag) * \(timeIncrease) * \(Float(Int((currentValue / timeIncreasePoint) % timeReset))) )")
            
            return Int(timeStart + (resetFlag * timeIncrease * Float(Int((currentValue / timeIncreasePoint) % timeReset))))
        }
    }
    var timeIncreaseValue:Float?
    var timeIncreaseAtPoints:Float?
    var timeResetInterval:Float?
    var penaltyPerDay:Float?
    var lastTimePointAdded:NSDate
    var lastTimeUpdated:NSDate
    
    
    var description: String {
        return "Name:\(name) - Description:\(entryDescription) - Value:\(currentValue) \n\t\t - TimeIncrease:\(timeIncreaseValue) - TimeResetAt:\(timeResetInterval) - TimeIncreaseAt:\(timeIncreaseAtPoints) \n\t\t - SpeedIncrease:\(speedIncreaseValue) - SpeedResetAt:\(speedResetInterval) - SpeedIncreaseAt:\(speedResetInterval) "
    }

}

class StatsBaseModel {
    
    var entryList:Array<StatsEntry>

    class var sharedInstance : StatsBaseModel
    {
        struct Static {
            static let instance : StatsBaseModel = StatsBaseModel()
        }
        return Static.instance
    }
    
    init() {
    
        entryList = Array<StatsEntry>()
        
        var plistDict: NSDictionary?
        
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.AllDomainsMask, true)[0] as! String
        var firstPath = paths.stringByAppendingPathComponent("StatsWorld.plist")
        plistDict = NSDictionary(contentsOfFile: firstPath)

        if plistDict == nil {
            if let path = NSBundle.mainBundle().pathForResource("StatsWorld", ofType: "plist") {
                plistDict = NSDictionary(contentsOfFile: path)
            }
        }
        
        if let dict = plistDict {
            if let elements = dict["Elements"] as? NSArray {
                for element in elements {
                    
                    if let name = element["Name"] as? String {
                        if let currentValue = element["CurrentValue"] as? Float {
                            if let timeStartValue = element["TimeStartValue"] as? Float {
                                if let lastTimePointAdded = element["LastTimePointAdded"] as? NSDate {
                                    if let lastTimeUpdated =  element["LastTimeUpdated"] as? NSDate {
                                    
                                        var entry = StatsEntry(
                                            name: name,
                                            entryDescription: nil,
                                            currentValue: currentValue,
                                            speedStartValue: nil,
                                            speedIncreaseValue: nil,
                                            speedIncreaseAtPoints: nil,
                                            speedResetInterval: nil,
                                            timeStartValue: timeStartValue,
                                            timeIncreaseValue: nil,
                                            timeIncreaseAtPoints: nil,
                                            timeResetInterval: nil,
                                            penaltyPerDay: nil,
                                            lastTimePointAdded: lastTimePointAdded,
                                            lastTimeUpdated:lastTimeUpdated)
                                        
                                        entry.entryDescription = element["Description"] as? String
                                        entry.speedStartValue = element["SpeedStartValue"] as? Float
                                        entry.speedIncreaseValue = element["SpeedIncreaseValue"] as? Float
                                        entry.speedIncreaseAtPoints = element["SpeenIncreaseAtPoints"] as? Float
                                        entry.speedResetInterval = element["SpeedResetInterval"] as? Float
                                        entry.timeIncreaseValue = element["TimeIncreaseValue"] as? Float
                                        entry.timeIncreaseAtPoints = element["TimeIncreaseAtPoints"] as? Float
                                        entry.timeResetInterval = element["TimeResetInterval"] as? Float
                                        entry.penaltyPerDay = element["PenaltyPerDay"] as? Float
                                        
                                        entryList.append(entry)
                                        
                                        //println("\(entry)")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func saveEntryList() {
        
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.AllDomainsMask, true)[0] as! String
        var path = paths.stringByAppendingPathComponent("StatsWorld.plist")
        
        // convert entryList to the right format
        var elementsArray = NSMutableArray()
        
        for element in entryList {
        
            var convertedElement = [
                "Name"              : element.name ,
                "CurrentValue"      : element.currentValue,
                "LastTimePointAdded": element.lastTimePointAdded,
                "LastTimeUpdated"   : element.lastTimeUpdated,
                "TimeStartValue"    : element.timeStartValue]
            
            if let description =  element.entryDescription {
                convertedElement["Description"] = description
            }

            if let penality = element.penaltyPerDay {
                convertedElement["PenaltyPerDay"] = penality
            }

            if let speedStart =  element.speedStartValue {
                convertedElement["SpeedStartValue"] = speedStart
            }
            
            if let speedIncrease =  element.speedIncreaseValue {
                convertedElement["SpeedIncreaseValue"] = speedIncrease
            }
            
            if let speenAtPoint = element.speedIncreaseAtPoints {
                convertedElement["SpeenIncreaseAtPoints"] = speenAtPoint
            }
            
            if let speedReset =  element.speedResetInterval {
                convertedElement["SpeedResetInterval"] = speedReset
            }
            
            if let timeIncrease =  element.timeIncreaseValue {
                convertedElement["TimeIncreaseValue"] = timeIncrease
            }
            
            if let timeAtPoint = element.timeIncreaseAtPoints {
                convertedElement["TimeIncreaseAtPoints"] = timeAtPoint
            }
            
            if let timeReset =  element.timeResetInterval {
                convertedElement["TimeResetInterval"] = timeReset
            }

            elementsArray.addObject(convertedElement)
        }
        
        let rootDict = ["Elements" : elementsArray] as NSDictionary
        
        rootDict.writeToFile(path, atomically: true)
        
    }
    
    func updateAllEntry() {
        
        // get today without time
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let today = cal!.startOfDayForDate(NSDate())
        
        // update the date for all the entryes
        for (index, var entry) in enumerate(entryList) {
        
            let unit = NSCalendarUnit.CalendarUnitDay
            let components = cal!.components(unit, fromDate:entry.lastTimeUpdated , toDate:today , options: nil)
            
            if let penality = entry.penaltyPerDay {
                if components.day > 2 {
                    
                    entry.currentValue -= Float(components.day - 2) * penality
                    entry.currentValue = entry.currentValue < 0 ? 0.0 : entry.currentValue
                    
                    entryList[index] = entry
                }
            }
        }
     }
}

