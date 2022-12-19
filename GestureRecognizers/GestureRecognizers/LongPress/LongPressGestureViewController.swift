import UIKit

class LongPressGestureViewController: UIViewController {
   
    @IBAction func longPressHandler(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            blurView.isHidden = true
        }
        if sender.state == .ended { // != .changed
            blurView.isHidden = false
        }
        
        //Discrete? continuous?? -> Continuous
    }
    @IBOutlet weak var blurView: UIVisualEffectView!
   
 
   
   
   
}
