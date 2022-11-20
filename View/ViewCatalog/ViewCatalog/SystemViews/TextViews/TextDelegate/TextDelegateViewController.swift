import UIKit

class TextDelegateViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    var regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    lazy var charSet = CharacterSet(charactersIn: "0123456789").inverted
    lazy var invalidGenderCharSet = CharacterSet(charactersIn: "MF").inverted
    
    
    /**
     - TEXTFIELD
     
     TAP => textFieldShouldBeginEditing(_:) -> true?
     => BecomeFirstResponder
     START_EDITING => textFieldBeginEditing(_:) : {
     
        textField(_:shouldChangeCharactersIn:replacementString:)
        clearBtn -> textFieldShouldClear(_:)
        returnBtn -> textFieldShouldReturn(_:)
     
     }
     
     END_EDITING => textFieldShouldEndEditing(_:) -> true? ResignFirstResponder
     => textFieldDidEndEditing(_:)
---------------------------------------------------------------------
     - TEXTVIEW
     
     TAP => textViewShouldBeginEditing(_:) -> true?
     => BecomeFirstResponder
     START_EDITING => textViewDidBeginEditing(_:) :{
     
        textView(_:shouldChangeTextIn:replacementText:)
        change -> textViewDidChange(_:)
        select -> textViewDidChangeSelection(_:)
        dataSetInteraction -> textView(_:shouldInteractWith:In:interaction:)
     
     }
     
     END_EDITING => textViewShouldEndEditing(_:) -> true? ResignFirstResponder
     => textViewDidEndEditing(_:)
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.becomeFirstResponder()
    }
}

extension TextDelegateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case nameField:
                ageField.becomeFirstResponder()
            case ageField:
                genderField.becomeFirstResponder()
            case genderField:
                emailField.becomeFirstResponder()
            case emailField:
                emailField.resignFirstResponder()
            default:
                break;
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("CURRENT: \(textField.text ?? "")")
        print("String: \(string)")
        
        let currentText = NSString(string: textField.text ?? "")
        let finalText = currentText.replacingCharacters(in: range, with: string)
        
        switch textField {
            case nameField:
                if finalText.count > 10 {
                    return false
                }
            case ageField:

                //붙여넣기 이슈 && 외부 키보드시 문자 들어감
                if let _ = string.rangeOfCharacter(from: charSet) {
                    return false
                }
                if let age = Int(finalText), !( 1...100).contains(age){
                    return false
                }
                
            case genderField:
                if finalText.count > 1 {
                    return false
                }
                if  let _ =  string.rangeOfCharacter(from: invalidGenderCharSet) {
                    return false
                }
            
            default:
                break;
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == emailField {
            guard let email = textField.text, let _ = email.range(of: regex, options: .regularExpression) else {
                alert(message: "invalid email")
                return false
            }
        }
        return true
    }
}












extension TextDelegateViewController {
    func alert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

















