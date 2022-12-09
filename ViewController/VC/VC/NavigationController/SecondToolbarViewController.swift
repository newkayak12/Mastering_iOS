
import UIKit

class SecondToolbarViewController: UIViewController {
    
    @IBAction func toggleToolbar(_ sender: Any) {
        let hidden = navigationController?.isToolbarHidden ?? false
        
        navigationController?.setToolbarHidden(!hidden, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let item = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        item.tintColor = .systemRed
        setToolbarItems([flexibleSpaceItem, item, flexibleSpaceItem], animated: true)
    }
}



























