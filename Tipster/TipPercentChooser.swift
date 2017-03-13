//
//  TipPercentChooser.swift
//  Tipster
//
//  Created by Jonathan Stone on 3/13/17.
//  Copyright © 2017 com.jonathan. All rights reserved.
//

import Foundation;
import UIKit;

class TipPercentChooser {
    
    static func updateDisplayedPercentages(tipPercentControl: UISegmentedControl, appSettings: TipsterSettings){
        let moodMultiplier = appSettings.getSelectedMoodValue();
        let tipCalculator = TipCalculator(moodMultiplier: moodMultiplier);
        let percentages = tipCalculator.makeTipPercentages();
        TipPercentChooser.setDisplayedPercentages(tipPercentControl: tipPercentControl, percentages: percentages);
    }

    static func setDisplayedPercentages(tipPercentControl: UISegmentedControl, percentages: Array<Double>)
    {
        for(index, percent) in percentages.enumerated()
        {
            let percentString = TipPercentChooser.formatPercentAsString(percent: percent);
            tipPercentControl.setTitle(percentString, forSegmentAt: index);
        }
    }

    static func formatPercentAsString(percent: Double)->String {
        let percentAsInteger = Int(100 * percent);
        return String("\(percentAsInteger)%");
    }
}
