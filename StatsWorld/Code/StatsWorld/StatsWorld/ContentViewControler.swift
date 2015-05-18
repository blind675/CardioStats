//
//  ContentViewControler.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 3/15/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import Foundation

import UIKit

class ContentViewControler: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var progressIndicator: ProgressView!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var speedIncreasePerPointLabel: UILabel!
    @IBOutlet weak var speedIncreaseEveryLabel: UILabel!
    @IBOutlet weak var speedResetLabel: UILabel!
    @IBOutlet weak var timeIncreasePerPointLabel: UILabel!
    @IBOutlet weak var timeIncreaseEveryLabel: UILabel!
    @IBOutlet weak var timeResetLabel: UILabel!
    @IBOutlet weak var penalityLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    weak var tableView: UITableView!
    weak var mainViewController: ViewController!
    private var selectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addButton.layer.cornerRadius = 4
        addButton.layer.masksToBounds = true
        addButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addButton.setTitleColor(UIColor.lightGrayColor(), forState: .Disabled)

        updateWithDataForTableRowIndex(0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonPressed() {
        
        StatsModel.pointAdded()
//            println("1: \(entry)")
        updateWithDataForTableRowIndex(selectedIndex)
//            println("2: \(entry)")
    }

    @IBAction func SpeachButtonPresed() {
        
    }
    
    func updateWithDataForTableRowIndex(index:Int) {
    
        if let entry = StatsModel.currentlySelectedEntry {
            
            println("3: \(entry)")
            
            selectedIndex = index
            
            descriptionLabel.text = entry.entryDescription ?? ""
            progressIndicator.currentValue = entry.currentValue
            
            if let speedIncreaseValue = entry.speedIncreaseValue {
                
                var speedIncreaseString = "- Speed increase per point : \(speedIncreaseValue)"
                
                var stringRange = NSRange(location: 0, length: 28)
                var valueRange = NSRange(location: 28, length: 4)
                var speedIncreaseMutableString = NSMutableAttributedString(string: speedIncreaseString)
                
                speedIncreaseMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
                speedIncreaseMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: stringRange)
                speedIncreaseMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: valueRange)
                
                speedIncreasePerPointLabel.attributedText = speedIncreaseMutableString
            
            } else {
                speedIncreasePerPointLabel.text = "- Speed increase per point : -"
            }
            
            if let speedIncreaseAtPoints = entry.speedIncreaseAtPoints {
                
                var speedIncreaseAtPointsString = "- Speed increase every \(speedIncreaseAtPoints) points "
                
                var stringRange = NSRange(location: 0, length: 34)
                var valueRange = NSRange(location: 23, length: 4)
                var speedIncreaseAtPointsMutableString = NSMutableAttributedString(string: speedIncreaseAtPointsString)
                
                speedIncreaseAtPointsMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
                speedIncreaseAtPointsMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: stringRange)
                speedIncreaseAtPointsMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: valueRange)
                
                speedIncreaseEveryLabel.attributedText = speedIncreaseAtPointsMutableString
            } else {
                speedIncreaseEveryLabel.text = "- Speed increase every - points "
            }

            if let speedResetInterval = entry.speedResetInterval {
                
                var speedResetIntervalString = "- Speed reset every \(speedResetInterval) points "
                
                var stringRange = NSRange(location: 0, length: 30)
                var valueRange = NSRange(location: 20, length: 4)
                var speedResetIntervalMutableString = NSMutableAttributedString(string: speedResetIntervalString)
                
                speedResetIntervalMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
                speedResetIntervalMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: stringRange)
                speedResetIntervalMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: valueRange)
                
                speedResetLabel.attributedText = speedResetIntervalMutableString
            } else {
                speedResetLabel.text = "- Speed reset every - points "
            }

            if let timeIncreaseValue = entry.timeIncreaseValue {
                
                var timeIncreaseValueString = "- Time increase per point \(timeIncreaseValue) "
                
                var stringRange = NSRange(location: 0, length: 26)
                var valueRange = NSRange(location: 26, length: 4)
                var timeIncreaseValueMutableString = NSMutableAttributedString(string: timeIncreaseValueString)
                
                timeIncreaseValueMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
                timeIncreaseValueMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: stringRange)
                timeIncreaseValueMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: valueRange)
                
                timeIncreasePerPointLabel.attributedText = timeIncreaseValueMutableString
            } else {
                timeIncreasePerPointLabel.text = "- Time increase per point -"
            }
            
            if let timeIncreaseAtPoints = entry.timeIncreaseAtPoints {
                
                var timeIncreaseAtPointsString = "- Time increase every \(timeIncreaseAtPoints) points "
                
                var stringRange = NSRange(location: 0, length: 33)
                var valueRange = NSRange(location: 22, length: 4)
                var timeIncreaseAtPointsMutableString = NSMutableAttributedString(string: timeIncreaseAtPointsString)
                
                timeIncreaseAtPointsMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
                timeIncreaseAtPointsMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: stringRange)
                timeIncreaseAtPointsMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: valueRange)
                
                timeIncreaseEveryLabel.attributedText = timeIncreaseAtPointsMutableString
            } else {
                timeIncreaseEveryLabel.text = "- Time increase every - points "
            }
            
            if let timeResetInterval = entry.timeResetInterval {
                
                var timeResetIntervalString = "- Time reset every \(timeResetInterval) points "
                
                var stringRange = NSRange(location: 0, length: 31)
                var valueRange = NSRange(location: 19, length: 4)
                var timeResetIntervalMutableString = NSMutableAttributedString(string: timeResetIntervalString)
                
                timeResetIntervalMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
                timeResetIntervalMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: stringRange)
                timeResetIntervalMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: valueRange)
                
                timeResetLabel.attributedText = timeResetIntervalMutableString
            } else {
                timeResetLabel.text = "- Time reset every - points "
            }

            if let penalityPerPoint = entry.penaltyPerDay {
                
                let penalityPerPointString = "- Penality points per day \(penalityPerPoint) "
                
                var stringRange = NSRange(location: 0, length: 26)
                var valueRange = NSRange(location: 26, length: 4)
                var penalityPerPointMutableString = NSMutableAttributedString(string: penalityPerPointString)
                
                penalityPerPointMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
                penalityPerPointMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: stringRange)
                penalityPerPointMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: valueRange)
                
                penalityLabel.attributedText = penalityPerPointMutableString
            } else {
                penalityLabel.text = "- Penality points per day - "
            }
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            var dateString = dateFormatter.stringFromDate(entry.lastTimePointAdded)
            let lastUpdateString = "- Last time updated points on: \(dateString) "
                
            var stringRange = NSRange(location: 0, length: 31)
            var valueRange = NSRange(location: 31, length: 10)
            var lastUpdateMutableString = NSMutableAttributedString(string: lastUpdateString)
                
            lastUpdateMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: stringRange)
            lastUpdateMutableString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(14), range: valueRange)
                
            lastUpdateLabel.attributedText = lastUpdateMutableString
            
            // neede for next point
            let infoString:NSString = "Needed for next point: \(entry.speedNeedeForNextPoint) speed - \(entry.timeNeededForNextPoint) min"
            
            var totalStringRange = NSRange(location: 0, length: infoString.length)
            var speedStringRange = NSRange(location: 23, length: 4)
            var timeStringRange = NSRange(location: 35, length: 3)
            
            var infoMutableString = NSMutableAttributedString(string: infoString as String)
            
            infoMutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(14), range: totalStringRange)
            infoMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: totalStringRange)
            infoMutableString.addAttribute(NSForegroundColorAttributeName, value: Tool.colorForValue(entry.currentValue), range: speedStringRange)
            infoMutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16), range: speedStringRange)
            infoMutableString.addAttribute(NSForegroundColorAttributeName, value: Tool.colorForValue(entry.currentValue), range: timeStringRange)
            infoMutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(16), range: timeStringRange)
            
            infoLabel.attributedText = infoMutableString
            
            println("\(infoString)")
            
            // enable / disable the add button based on the date 
            // get today witout time
            let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
            let today = cal!.startOfDayForDate(NSDate())
            
            if today.compare(entry.lastTimeUpdated) == NSComparisonResult.OrderedSame {
                addButton.enabled = false
            } else {
                addButton.enabled = true
            }

            // also update the info label, table row and the overall indicator ( to be implemented )
            
            mainViewController.refreshUI()
        }
        
    }
    
    
}