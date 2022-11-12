
import UIKit

class ClippingViewController: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var clippingSwitch: UISwitch!
    
    @IBAction func toggleClipToBounds(_ sender: UISwitch) {
        redView.clipsToBounds = sender.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clippingSwitch.isOn = redView.clipsToBounds
    }
}
