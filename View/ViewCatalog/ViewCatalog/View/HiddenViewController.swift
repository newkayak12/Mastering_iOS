import UIKit

class HiddenViewController: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var hiddenSwitch: UISwitch!
    
    @IBAction func toggleHidden(_ sender: UISwitch) {
        redView.isHidden = sender.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenSwitch.isOn = redView.isHidden
        
        
    }
}
