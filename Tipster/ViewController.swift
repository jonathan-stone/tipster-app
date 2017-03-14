import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipPercentControl: UISegmentedControl!

    var settings: TipsterSettings? = nil;
    var keepKeyboardVisible = true;
    var didLoadSelectedPercentIndex = false;
    var maxTimeToSaveBill: Int = 10 * 60;

    override func viewDidLoad() {
        super.viewDidLoad();
        applySavedSettings();
        setTitleImage();
        clearBillAmount();
        preventKeyboardAnimations();
    }

    override func viewWillAppear(_ animated: Bool) {
        applySavedSettings();
        keepKeyboardVisible = true;
        showTheKeyboard();
    }

    func setTitleImage() {
        let imageSize = CGRect(x: 0, y: 0, width: 60, height: 20);

        let titleView = UIImageView(frame: imageSize);
        titleView.contentMode = .scaleAspectFit;
        titleView.image = UIImage(named: "tipster_title.png");

        self.navigationItem.titleView = titleView
    }

    func clearBillAmount() {
        billTextField.text = String();
    }

    func showTheKeyboard() {
        billTextField.becomeFirstResponder();
    }

    func preventKeyboardAnimations() {
        billTextField.delegate = self;
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return !keepKeyboardVisible;
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable keyboard sliding into view animation.
        UIView.setAnimationsEnabled(false);
    }

    func didShowKeyboard(_ notification: Notification) {
        // Re-enable animations.
        UIView.setAnimationsEnabled(true);
    }

    func getSettings()->TipsterSettings {
        if(settings == nil)
        {
            settings = TipsterSettings();
            applySavedSettings();
        }

        return settings!;
    }

    func getTipCalculator(appSettings: TipsterSettings!)->TipCalculator {
        return TipCalculator(moodMultiplier: appSettings.getSelectedMoodValue());
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onTipPercentageChanged(_ sender: AnyObject) {
        calculateTip();
    }

    @IBAction func onBillAmountChanged(_ sender: AnyObject) {
        let appSettings = getSettings();
        if let billText = billTextField.text {
            persistBillText(appSettings: appSettings, billText: billText);
        }

        calculateTip();
    }

    func calculateTip() {
        let appSettings = getSettings();

        let tipCalculator = getTipCalculator(appSettings: appSettings);
        let bill = getBillAmount();

        let tip = tipCalculator.calculateTip(bill: bill, selectedTipIndex: tipPercentControl.selectedSegmentIndex);
        let total = bill + tip;

        setCalculatedLabelText(tip: tip, total: total);
    }

    func getBillAmount()->Decimal {
        return decimalFromCurrencyString(withCurrencyString: billTextField.text!);
    }

    func persistBillText(appSettings: TipsterSettings, billText: String) {
        appSettings.setBillText(toAmount: billText);
    }

    func setCalculatedLabelText(tip: Decimal, total: Decimal) {
        tipLabel.text = toCurrencyFormat(amount: tip);
        totalLabel.text = toCurrencyFormat(amount: total);
    }

    func decimalFromCurrencyString(withCurrencyString: String)->Decimal {
        let formatter = NumberFormatter();
        if let number = formatter.number(from: withCurrencyString) {
            return number.decimalValue;
        }

        return 0;
    }

    func toCurrencyFormat(amount: Decimal)->String {
        let formatter = NumberFormatter();
        formatter.numberStyle = .currency;
        if let formattedString = formatter.string(from: amount as NSNumber) {
            return formattedString;
        }

        return String();
    }

    func applySavedSettings() {
        let appSettings = getSettings();
        applySettingsValuesToUiControls(appSettings: appSettings);
        calculateTip();
    }

    func applySettingsValuesToUiControls(appSettings: TipsterSettings) {
        if (!didLoadSelectedPercentIndex) {
            // Only load on startup. If user goes into settings and changes the default index, it should not be reflected in this view.
            tipPercentControl.selectedSegmentIndex = appSettings.getSelectedTipIndex();
            didLoadSelectedPercentIndex = true;
        }

        TipPercentChooser.updateDisplayedPercentages(tipPercentControl: tipPercentControl, appSettings: appSettings);
        applyPersistedBillAmount(appSettings: appSettings);
    }

    func applyPersistedBillAmount(appSettings: TipsterSettings) {
        let savedAt =  appSettings.getBillTextLastSavedAt();
        print("Saved at \(savedAt)");
        if (isYoungerThan(date: savedAt, timeIntervalInSeconds: maxTimeToSaveBill)) {
            print("It's younger. Getting saved bill amount");
            if let savedBillAmount = appSettings.getBillText() {
                if (!savedBillAmount.isEmpty)
                {
                    print("Applying saved bill amount \(savedBillAmount)");
                    billTextField.text = savedBillAmount;
                }
            }
        }

    }

    func isYoungerThan(date: Date, timeIntervalInSeconds: Int)->Bool {
        let difference = Date().timeIntervalSince(date);
        print("Difference between now and the saved date: \(difference)");
        return difference < TimeInterval(timeIntervalInSeconds);
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        keepKeyboardVisible = false;
        billTextField.endEditing(false);
    }

}

