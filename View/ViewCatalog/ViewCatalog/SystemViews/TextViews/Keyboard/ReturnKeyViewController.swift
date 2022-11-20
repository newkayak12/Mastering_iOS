import UIKit

class ReturnKeyViewController: UIViewController {
    
    @IBOutlet weak var firstInputField: UITextField!
    
    @IBOutlet weak var secondInputField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondInputField.enablesReturnKeyAutomatically = true
    }
}


extension ReturnKeyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            case firstInputField:
                secondInputField.becomeFirstResponder()
            case secondInputField:
                guard let keyword = secondInputField.text, keyword.count > 0  else {
                    return true
                }
                let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword
                let urlStr = "http://www.google.com/m/search?q=\(encodedKeyword)"
                guard let url = URL(string: urlStr) else {
                    return true
                }
                
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler:  nil)
                }
            default:
                break;
        }
        
        return true
    }
}
