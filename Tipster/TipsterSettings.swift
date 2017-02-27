import Foundation

class TipsterSettings: AnyObject {
    let tipPercentKey = "tipster_tipPercent_selectedIndex";
    let defaultIndex = 0;

    var selectedPercentIndex = 0;

    func saveSettings() {
        let defaults = UserDefaults.standard;
        defaults.set(selectedPercentIndex, forKey: tipPercentKey);
        defaults.synchronize()
    }

    func loadSettings() {
        let defaults = UserDefaults.standard;
        selectedPercentIndex = defaults.integer(forKey: tipPercentKey);
        print("Loaded settings. selectedPercentIndex: \(selectedPercentIndex)");
    }

    func getSelectedTipIndex()->Int
    {
        loadSettings();
        return selectedPercentIndex;
    }

    func setSelectedTipIndex(selectedIndex: Int)
    {
        selectedPercentIndex = selectedIndex;
        print("Saving settings. selectedPercentIndex: \(selectedPercentIndex)");
        saveSettings();
    }
}
