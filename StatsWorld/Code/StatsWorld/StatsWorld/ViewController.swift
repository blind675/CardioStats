//
//  ViewController.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 2/28/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var overallValues: UILabel!
    
    weak var panelController:JASidePanelMainController?
    weak var contentViewController: ContentViewControler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        StatsModel.selectedIndex = 0
        
        refreshUI()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StatsModel.numberOfEntryes()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath) as! TableViewCell
        
        if let entry = StatsModel.entryForIndex(indexPath.row) {
            cell.nameLabel.text = entry.name
            
            cell.valueLabel.backgroundColor = Tool.colorForValue(entry.currentValue)
            cell.valueLabel.layer.cornerRadius = 4
            cell.valueLabel.layer.masksToBounds = true
            
            cell.valueLabel.text = "\(entry.currentValue)"
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if indexPath.row == StatsModel.selectedIndex {
                cell.contentView.backgroundColor = UIColor(netHex: 0x232335)
            } else {
                cell.contentView.backgroundColor = UIColor.blackColor()
            }
        }
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        StatsModel.selectedIndex = indexPath.row
        tableView.reloadData()
        
        if let contentVC = contentViewController {
            contentVC.updateWithDataForTableRowIndex(StatsModel.selectedIndex)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationVC = segue.destinationViewController as? ContentViewControler {
            destinationVC.mainViewController = self
            contentViewController = destinationVC
        }
    }
    
    func refreshUI() {
        
        if let lastDate = NSUserDefaults.standardUserDefaults().objectForKey(kLastAddedDateKey) as? NSDate
        {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            var dateString = dateFormatter.stringFromDate(lastDate)
            infoLabel.text = "Last time used: \(dateString)"
        } else {
            infoLabel.text = "Last time used: -"
        }

        // refrefs value and color for over all view 
        overallValues.text = "Overall: \(StatsModel.overallValue())"
        overallValues.backgroundColor = Tool.colorForValue(StatsModel.overallValue())
        
        let indexPath = NSIndexPath(forItem: StatsModel.selectedIndex, inSection: 0)
        // thi is a cool animation and it should be used more
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    

    @IBAction func infoPushed() {
        if let panelCtrl = panelController {
            panelCtrl.toggleRightPanel(self)
        }
    }
    
}

