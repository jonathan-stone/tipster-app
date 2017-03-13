//
//  TipCalculator.swift
//  Tipster
//
//  Created by Jonathan Stone on 3/12/17.
//  Copyright © 2017 com.jonathan. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class TipCalculator
{
    let defaultTipPercentages = [0.1, 0.15, 0.2];
    var multiplier: Double!;

    init(moodMultiplier: Double!) {
        multiplier = moodMultiplier;
    }

    func makeTipPercentages() ->Array<Double>
    {
        var result = Array<Double>();
        for percent in defaultTipPercentages {
            result.append((percent * multiplier).roundTo(places: 2));
        }
        
        return result;
    }

    func calculateTip(bill: Double, selectedTipIndex: Int)->Double
    {
        let tipPercentages = makeTipPercentages();
        let selectedPercentage = tipPercentages[selectedTipIndex];

        let tip = bill * selectedPercentage;
        print("Calculated tip \(tip) for bill \(bill) with percentage \(selectedPercentage)");
        return tip;
    }


}

