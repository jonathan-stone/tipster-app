//
//  TipCalculator.swift
//  Tipster
//
//  Created by Jonathan Stone on 3/12/17.
//  Copyright © 2017 com.jonathan. All rights reserved.
//

import Foundation

extension Decimal {
    func roundTo(places: Int16) ->  Decimal {
        let decnum = NSDecimalNumber(decimal: self);
        let numConverter = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.bankers,
                                                  scale: places,
                                                  raiseOnExactness: true,
                                                  raiseOnOverflow: true,
                                                  raiseOnUnderflow: true,
                                                  raiseOnDivideByZero: false);

        let rounded = decnum.rounding(accordingToBehavior: numConverter);
        return rounded as Decimal;
    }
}

class TipCalculator
{
    let defaultTipPercentages: Array<Decimal> = [0.1, 0.15, 0.2];
    var multiplier: Decimal!;

    init(moodMultiplier: Double!) {
        multiplier = Decimal(moodMultiplier);
    }

    func makeTipPercentages() ->Array<Decimal>
    {
        var result = Array<Decimal>();
        for percent in defaultTipPercentages {
            result.append((percent * multiplier).roundTo(places: 2));
        }
        
        return result;
    }

    func calculateTip(bill: Decimal, selectedTipIndex: Int)->Decimal
    {
        let tipPercentages = makeTipPercentages();
        let selectedPercentage = tipPercentages[selectedTipIndex];

        let tip = bill * selectedPercentage;
        print("Calculated tip \(tip) for bill \(bill) with percentage \(selectedPercentage)");
        return tip;
    }


}

