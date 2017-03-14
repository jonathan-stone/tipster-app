import Foundation

class TipsterSettings: AnyObject {
    let tipPercentKey = "tipster_tipPercent_selectedIndex";
    let moodValueKey = "tipster_mood_value";
    let billTextKey = "tipster_billText";
    let billTextLastSavedAtKey = "tipster_billTextLastSavedAt";
    let defaultIndex = 0;
    let defaultMood = 0.5;
    var selectedMoodValue: Double = 0.5;
    var billText: String? = nil;
    var billTextLastSavedAt = Date.distantPast;

    var selectedPercentIndex = 0;

    func saveSettings() {
        let defaults = UserDefaults.standard;
        defaults.set(selectedPercentIndex, forKey: tipPercentKey);
        defaults.set(selectedMoodValue, forKey: moodValueKey);
        defaults.set(billText, forKey: billTextKey);
        defaults.set(billTextLastSavedAt, forKey: billTextLastSavedAtKey);
        defaults.synchronize();
    }

    func loadSettings() {
        let defaults = UserDefaults.standard;
        selectedPercentIndex = defaults.integer(forKey: tipPercentKey);
        selectedMoodValue = defaults.double(forKey: moodValueKey);
        if let restoredBillText = defaults.string(forKey: billTextKey) {
            billText = restoredBillText;
        }

        if let restoredBillTextSavedDate = defaults.object(forKey: billTextLastSavedAtKey) as? Date {
            billTextLastSavedAt = restoredBillTextSavedDate;
        }


        print("Loaded settings. selectedPercentIndex: \(selectedPercentIndex). \n selectedMoodValue: \(selectedMoodValue)" );
    }

    func getSelectedTipIndex()->Int {
        loadSettings();
        return selectedPercentIndex;
    }

    func getSelectedMoodValue()->Double {
        loadSettings();
        return selectedMoodValue;
    }

    func setSelectedTipIndex(selectedIndex: Int) {
        selectedPercentIndex = selectedIndex;
        print("Saving settings. selectedPercentIndex: \(selectedPercentIndex)");
        saveSettings();
    }

    func setSelectedMoodValue(moodValue: Double) {
        selectedMoodValue = moodValue;
        saveSettings();

    }

    func setBillText(toAmount: String) {
        billText = toAmount;
        billTextLastSavedAt = Date();
        print("Bill last saved at \(billTextLastSavedAt)");
        saveSettings();
    }

    func getBillText()->String? {
        loadSettings();
        return billText;
    }

    func getBillTextLastSavedAt()->Date {
        loadSettings();
        return billTextLastSavedAt;
    }
}
