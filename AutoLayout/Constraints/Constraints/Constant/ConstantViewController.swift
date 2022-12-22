import UIKit

class ConstantViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var blueViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var grayButton: UIButton!
    @IBOutlet weak var grayButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonBottom: NSLayoutConstraint!
    
    @IBAction func updateConstant(_ sender: Any) {
//        blueView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        blueViewLeadingConstraint.constant = 100
        blueViewTopConstraint.constant = 100
        
        blueViewWidthConstraint.constant = 200
        blueViewHeightConstraint.constant = 200
        if(buttonBottom.constant == 0){
            buttonBottom.constant =  (-view.frame.height / 2) + grayButton.frame.height
        } else {
            buttonBottom.constant = 0
        }
        
        
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
