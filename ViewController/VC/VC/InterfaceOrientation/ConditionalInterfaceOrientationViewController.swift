import UIKit

class ConditionalInterfaceOrientationViewController: UIViewController {
    
    var orientationMask: UIInterfaceOrientationMask = .all
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return orientationMask
    }
    
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            orientationMask = [.landscapeLeft, .landscapeRight]
        } else {
            orientationMask = .all
        }
        
        UIViewController.attemptRotationToDeviceOrientation()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}



























