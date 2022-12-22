import UIKit

class MenuViewController: UIViewController {

    
    
    @IBOutlet weak var leftEqualWidthContraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightEqualWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightCenterXConstraint: NSLayoutConstraint!
    
    @IBAction func selectLeft(_ sender: Any) {
        leftCenterXConstraint.priority = .required
        leftEqualWidthContraint.priority = .required //1000
        rightCenterXConstraint.priority = .defaultHigh //750
        rightEqualWidthConstraint.priority = .defaultHigh
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func selectRight(_ sender: Any) {
        leftCenterXConstraint.priority = .defaultHigh
        leftEqualWidthContraint.priority = .defaultHigh
        rightCenterXConstraint.priority = .required
        rightEqualWidthConstraint.priority = .required
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
