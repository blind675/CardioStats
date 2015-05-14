//
//  RightMenuController.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 5/13/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import UIKit

class RightMenuController : UIViewController {
 
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func speackButtonPressed() {
        SpeakingTexts.speackText(SpeakingTexts.descriptionText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = SpeakingTexts.descriptionText
    }
}
