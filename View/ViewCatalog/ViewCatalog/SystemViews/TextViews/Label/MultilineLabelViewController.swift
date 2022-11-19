import UIKit

class MultilineLabelViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var lineNumberLabel: UILabel!
    @IBOutlet weak var lineNumberStepper: UIStepper!
    @IBOutlet weak var autoshrinkSwitch: UISwitch!
    @IBOutlet weak var lineBreakModePicker: UIPickerView!
    
    
    
    @IBAction func updateLines(_ sender: UIStepper) {
        valueLabel.numberOfLines = Int(sender.value)
        lineNumberLabel.text = "\(valueLabel.numberOfLines)"
    }
    
    @IBAction func toggleAutoshrink(_ sender: UISwitch) {
        valueLabel.minimumScaleFactor = sender.isOn ? 0.5 : 0.0
        valueLabel.adjustsFontSizeToFitWidth = sender.isOn
        //autoShrink는 위의 두 가지 속성을 한 번에 바꿔야한다.
    }
    
    func changeLineBreakMode(with rawValue: Int) {
        if let mode = NSLineBreakMode(rawValue: rawValue) {
            valueLabel.lineBreakMode = mode
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineNumberLabel.text = "\(valueLabel.numberOfLines)"
        lineNumberStepper.value = Double(valueLabel.numberOfLines)
        
        autoshrinkSwitch.isOn = valueLabel.minimumScaleFactor != 0 &&
        valueLabel.adjustsFontSizeToFitWidth
        
        lineBreakModePicker.selectRow(valueLabel.lineBreakMode.rawValue,
                                        inComponent: 0, animated:false)
        
    }
}







extension MultilineLabelViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
}

extension MultilineLabelViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Word Wrap"
        case 1:
            return "Character Wrap"
        case 2:
            return "Clip"
        case 3:
            return "Truncating Head"
        case 4:
            return "Truncating Tail"
        case 5:
            return "Truncating Middle"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeLineBreakMode(with: row)
    }
}
