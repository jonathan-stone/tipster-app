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

    @IBOutlet var moodSlider: UISlider!
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

    @IBAction func onMoodValueChanged(_ sender: UISlider) {
        saveSettings();
        TipPercentChooser.updateDisplayedPercentages(tipPercentControl: tipPercentControl, appSettings: settings!);
    }

    @IBAction func onTipPercentageChanged(_ sender: AnyObject) {
        saveSettings();
    }

    func saveSettings()
    {
        let appSettings = getSettings();
        appSettings.setSelectedTipIndex(selectedIndex: tipPercentControl.selectedSegmentIndex);
        appSettings.setSelectedMoodValue(moodValue: Double(moodSlider.value));
    }

    func loadSettings()
    {
        let appSettings = getSettings();
        tipPercentControl.selectedSegmentIndex = appSettings.getSelectedTipIndex();
        moodSlider.value = Float(appSettings.getSelectedMoodValue());
        TipPercentChooser.updateDisplayedPercentages(tipPercentControl: tipPercentControl, appSettings: appSettings);

    }
}
