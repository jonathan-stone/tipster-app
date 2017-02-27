//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Jonathan Stone on 2/26/17.
//  Copyright © 2017 com.jonathan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentControl: UISegmentedControl!

    var settings: TipsterSettings?;

    override func viewDidLoad() {
        super.viewDidLoad();
        loadSettings();
    }

    func getSettings()->TipsterSettings
    {
        if(settings == nil)
        {
            settings = TipsterSettings();
            loadSettings();
        }

        return settings!;
    }

    @IBAction func onTipPercentageChanged(_ sender: AnyObject) {
        saveSettings();
    }

    func saveSettings()
    {
        let appSettings = getSettings();
        appSettings.setSelectedTipIndex(selectedIndex: tipPercentControl.selectedSegmentIndex);
    }

    func loadSettings()
    {
        let appSettings = getSettings();
        tipPercentControl.selectedSegmentIndex = appSettings.getSelectedTipIndex();
    }
}
