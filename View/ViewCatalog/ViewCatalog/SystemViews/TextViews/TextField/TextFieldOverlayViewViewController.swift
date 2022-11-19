import UIKit

class TextFieldOverlayViewViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @objc func showPredefinedValue() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let one = UIAlertAction(title: "One", style: .default) { (action) in
            self.inputField.text = action.title
        }
        sheet.addAction(one)
        
        let two = UIAlertAction(title: "Two", style: .default) { (action) in
            self.inputField.text = action.title
        }
        sheet.addAction(two)
        
        let three = UIAlertAction(title: "Three", style: .default) { (action) in
            self.inputField.text = action.title
        }
        sheet.addAction(three)
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        sheet.addAction(cancel)
        
        present(sheet, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        btn.setImage(UIImage(named: "menu"), for: .normal)
        btn.addTarget(self, action: #selector(showPredefinedValue), for: .touchUpInside)
        
        inputField.leftView = btn
        inputField.leftViewMode = .always
    }
}
