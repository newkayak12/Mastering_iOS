import UIKit

class TextDelegateViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    
    
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
}













extension TextDelegateViewController {
    func alert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

















