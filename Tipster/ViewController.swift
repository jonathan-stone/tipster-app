import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipPercentControl: UISegmentedControl!

    var settings: TipsterSettings? = nil;

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

    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func onTipPercentageChanged(_ sender: AnyObject) {
        calculateTip();
    }

    @IBAction func onBillAmountChanged(_ sender: AnyObject) {
        calculateTip();
    }

    func calculateTip() {
        let tipPercentages = [0.18, 0.2, 0.25];

        let bill = Double(billTextField.text!) ?? 0;
        let selectedPercentage = tipPercentages[tipPercentControl.selectedSegmentIndex];
        let tip = bill * selectedPercentage;
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
        tipPercentControl.selectedSegmentIndex = appSettings.getSelectedTipIndex();
    }
}

