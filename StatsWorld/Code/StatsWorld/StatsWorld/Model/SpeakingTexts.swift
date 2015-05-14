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
    
   internal static let descriptionText = "Welcome to CardioStats. This is an app to help you get in shape and obtain the form you have been wanting all your life. All You have to do is track your cardio activiti and always follow the guides. If you are asked to do a certain thing for next point please do so. When the top bar will become green you will become happy with your body. Money back guarantee."
    
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
    
}

