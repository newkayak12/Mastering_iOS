import UIKit

class AddTextFieldViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func show(_ sender: Any) {
        let controller = UIAlertController(title: "Sing In to iTunes", message: nil, preferredStyle: .alert)
        //경고창에 textField를 추가하는 것은 .alert만 가능
        
        controller.addTextField{
            (idField) in idField.placeholder = "Apple ID :)"
        }
        
        controller.addTextField{
            (passwordField) in
            passwordField.placeholder = "Input Password"
            passwordField.isSecureTextEntry = true
            
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            if let fieldList = controller.textFields {
                if let idField = fieldList.first {
                    self?.idLabel.text = idField.text
                }
                if let passwordField = fieldList.last {
                    self?.passwordLabel.text = passwordField.text
                }
            }
        }
        controller.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        present(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}


























