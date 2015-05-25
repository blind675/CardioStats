//
//  SpeakingTexts.swift
//  StatsWorld
//
//  Created by Catalin-Andrei BORA on 5/14/15.
//  Copyright (c) 2015 Bob Development. All rights reserved.
//

import Foundation
import AVFoundation

class SpeakingTexts {
    
   internal static let descriptionText = "Welcome to CardioStats. This is an app to help you get in shape and obtain the form you have been wanting all your life. All You have to do is track your cardio activiti and always follow the guides. If you are asked to do a certain thing for next point please do so. Tap on the speaker icon anytime you find it to get more information. When the top bar will become green you will become happy with your body. Money back guarantee."
    
    static private let synth = AVSpeechSynthesizer()
    static private var utterance = AVSpeechUtterance(string: "")
    
    class var sharedInstance : SpeakingTexts
    {
        struct Static {
            static let instance : SpeakingTexts = SpeakingTexts()
        }
        return Static.instance
    }
    
    static func speackText(text: String) {
        utterance = AVSpeechUtterance(string:text)
        utterance.rate = 0.2
        utterance.pitchMultiplier = 1.5
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        synth.speakUtterance(utterance)
    }
    
    static func speakForTheNextPoint() {
    
        if let entry = StatsModel.currentlySelectedEntry {
            var stringToSpeak = "For the next point you have to " + entry.entryDescription! + " for \(entry.timeNeededForNextPoint) minutes"
            
            if entry.speedNeedeForNextPoint != 0 {
                stringToSpeak += " at speed \(entry.speedNeedeForNextPoint)"
            }
            
            utterance = AVSpeechUtterance(string:stringToSpeak)
            utterance.rate = 0.2
            utterance.pitchMultiplier = 1.5
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            synth.speakUtterance(utterance)
            
        }
        
    }
    
}

