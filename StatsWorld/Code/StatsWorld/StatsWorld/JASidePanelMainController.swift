//
//  JASidePanelMainController.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 5/13/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//
//import JASidePanelController.h

import UIKit

class JASidePanelMainController : JASidePanelController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rightPanel = self.storyboard?.instantiateViewControllerWithIdentifier("menuController") as! UIViewController
        let cenerController = self.storyboard?.instantiateViewControllerWithIdentifier("mainController") as! ViewController
        cenerController.panelController = self
        self.centerPanel = cenerController
        self.pushesSidePanels = false
    }
}