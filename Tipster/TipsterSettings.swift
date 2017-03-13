import Foundation

class TipsterSettings: AnyObject {
    let tipPercentKey = "tipster_tipPercent_selectedIndex";
    let moodValueKey = "tipster_mood_value";
    let defaultIndex = 0;
    let defaultMood = 0.5;
    var selectedMoodValue: Double = 0.5;

    var selectedPercentIndex = 0;

    func saveSettings() {
        let defaults = UserDefaults.standard;
        defaults.set(selectedPercentIndex, forKey: tipPercentKey);
        defaults.set(selectedMoodValue, forKey: moodValueKey);
        defaults.synchronize()
    }

    func loadSettings() {
        let defaults = UserDefaults.standard;
        selectedPercentIndex = defaults.integer(forKey: tipPercentKey);
        selectedMoodValue = defaults.double(forKey: moodValueKey);

        print("Loaded settings. selectedPercentIndex: \(selectedPercentIndex). \n selectedMoodValue: \(selectedMoodValue)" );
    }

    func getSelectedTipIndex()->Int
    {
        loadSettings();
        return selectedPercentIndex;
    }

    func getSelectedMoodValue()->Double
    {
        loadSettings();
        return selectedMoodValue;
    }

    func setSelectedTipIndex(selectedIndex: Int)
    {
        selectedPercentIndex = selectedIndex;
        print("Saving settings. selectedPercentIndex: \(selectedPercentIndex)");
        saveSettings();
    }

    func setSelectedMoodValue(moodValue: Double) {
        selectedMoodValue = moodValue;
        saveSettings();

    }
}
