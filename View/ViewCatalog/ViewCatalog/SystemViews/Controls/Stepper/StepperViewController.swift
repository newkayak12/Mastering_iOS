import UIKit

class StepperViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueStepper: UIStepper!
    @IBOutlet weak var autorepeatSwitch: UISwitch!
    @IBOutlet weak var continuousSwitch: UISwitch!
    @IBOutlet weak var wrapSwitch: UISwitch!
    
    @IBAction func valueChanged(_ sender: UIStepper) {
        valueLabel.text = "\(sender.value)"
    }
    @IBAction func toggleAutorepeat(_ sender: UISwitch) {
        valueStepper.autorepeat = sender.isOn
    }
    
    @IBAction func toggleContinuous(_ sender: UISwitch) {
        valueStepper.isContinuous = sender.isOn
    }
    
    @IBAction func toggleWrap(_ sender: UISwitch) {
        valueStepper.wraps = sender.isOn
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autorepeatSwitch.isOn = valueStepper.autorepeat
        continuousSwitch.isOn = valueStepper.isContinuous
        wrapSwitch.isOn = valueStepper.wraps
        
    }
}











