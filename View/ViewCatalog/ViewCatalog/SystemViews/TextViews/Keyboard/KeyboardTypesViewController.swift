import UIKit

class KeyboardTypesViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func changeKeyboardType(_ sender: Any) {
        inputField.resignFirstResponder()
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let types: [UIKeyboardType] = [.default, .asciiCapable, .numbersAndPunctuation, .URL, .numberPad, .phonePad, .namePhonePad, .emailAddress, .decimalPad, .twitter, .webSearch, .asciiCapableNumberPad]
        let typeNames = ["Default", "ASCII Capable", "Numbers And Punctuation", "URL", "Number Pad", "Phone Pad", "Name Phone Pad", "E-mail Address", "Decimal Pad", "Twitter", "Web Search", "ASCII Capable Number Pad"]
        
        (0..<types.count).forEach {
            let type = types[$0]
            let name = typeNames[$0]
            
            let action = UIAlertAction(title: name, style: .default, handler: { (action) in
                self.inputField.keyboardType = type
                self.inputField.becomeFirstResponder()
            })
            sheet.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        sheet.addAction(cancel)
        
        if let pc = sheet.popoverPresentationController {
            pc.sourceView = btn
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
}
