import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipPercentControl: UISegmentedControl!

    var settings: TipsterSettings? = nil;
    var tipCalculator: TipCalculator? = nil;
    var keepKeyboardVisible = true;

    override func viewDidLoad() {
        super.viewDidLoad();
        loadSettings();
        setTitleImage();
        clearBillAmount();
        preventKeyboardAnimations();
    }

    override func viewWillAppear(_ animated: Bool) {
        loadSettings();
        keepKeyboardVisible = true;
        showTheKeyboard();
    }

    func setTitleImage()
    {
        let imageSize = CGRect(x: 0, y: 0, width: 60, height: 20);

        let titleView = UIImageView(frame: imageSize);
        titleView.contentMode = .scaleAspectFit;
        titleView.image = UIImage(named: "tipster_title.png");

        self.navigationItem.titleView = titleView
    }

    func clearBillAmount() {
        billTextField.text = String();
    }

    func showTheKeyboard()
    {
        billTextField.becomeFirstResponder();
    }

    func preventKeyboardAnimations()
    {
        billTextField.delegate = self;
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return !keepKeyboardVisible;
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable animations.
        UIView.setAnimationsEnabled(false);
    }

    func didShowKeyboard(_ notification: Notification) {
        // Enable animations.
        UIView.setAnimationsEnabled(true);
    }

    func getSettings()->TipsterSettings
    {
        if(settings == nil)
        {
            settings = TipsterSettings();
            loadSettings();
            tipCalculator = TipCalculator(moodMultiplier: settings!.getSelectedMoodValue());
        }

        return settings!;
    }

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onTipPercentageChanged(_ sender: AnyObject) {
        calculateTip();
    }

    @IBAction func onBillAmountChanged(_ sender: AnyObject) {
        calculateTip();
    }

    func calculateTip()
    {
        let appSettings = getSettings();

        let moodMultiplier = appSettings.getSelectedMoodValue();
        let tipCalculator = TipCalculator(moodMultiplier: moodMultiplier);
        let bill = Double(billTextField.text!) ?? 0;
        let tip = tipCalculator.calculateTip(bill: bill, selectedTipIndex: tipPercentControl.selectedSegmentIndex);

        let total = bill + tip;
        setCalculatedLabelText(tip: tip, total: total);
    }

    func setCalculatedLabelText(tip: Double, total: Double)
    {
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
    }

    func loadSettings()
    {
        let appSettings = getSettings();
        applySettingsValuesToUiControls(appSettings: appSettings);
        calculateTip();
    }

    func applySettingsValuesToUiControls(appSettings: TipsterSettings)
    {
        tipPercentControl.selectedSegmentIndex = appSettings.getSelectedTipIndex();
        TipPercentChooser.updateDisplayedPercentages(tipPercentControl: tipPercentControl, appSettings: appSettings);
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        keepKeyboardVisible = false;
        billTextField.endEditing(false);
    }

}

