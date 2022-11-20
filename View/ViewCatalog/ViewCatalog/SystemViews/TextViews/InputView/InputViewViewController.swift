import UIKit


class InputViewViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet var pickerContainerView: UIView!
    @IBOutlet var buttonContainerView: UIView!
    
    @IBOutlet var inputAccessory: UIToolbar!
    
    @IBAction func uiBar(_ sender: UIBarButtonItem) {
        switch sender.tag {
            case 0:
                if ageField.isFirstResponder {
                    nameField.becomeFirstResponder()
                }
                if genderField.isFirstResponder{
                    ageField.becomeFirstResponder()
                }
            case 1:
                if ageField.isFirstResponder {
                    genderField.becomeFirstResponder()
                }
                if nameField.isFirstResponder {
                    ageField.becomeFirstResponder()
                }
            default:
                break;
        }
    }
    
    @IBAction func selectGender(_ sender: UIButton) {
        genderField.text = sender.tag == 0 ? "M" : "F"
        /**
            UIInputViewAudioFeedback
            UIDevice 의 메소드
         */
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageField.inputView = pickerContainerView
        genderField.inputView = buttonContainerView
        
        nameField.inputAccessoryView = inputAccessory
        ageField.inputAccessoryView = inputAccessory
        genderField.inputAccessoryView = inputAccessory
        
    }
}


class GenderInputView: UIView, UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool {
        return true
    }
}



extension InputViewViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
}

extension InputViewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageField.text = "\(row + 1)"
    }
}












