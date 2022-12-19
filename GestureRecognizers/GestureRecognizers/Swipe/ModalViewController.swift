import UIKit

class ModalViewController: UIViewController {
   
    @IBAction func swipeDownHandler(_ sender: UISwipeGestureRecognizer) {
        
        if sender.state == .ended {
            dismiss(animated: true)
        }
    }
    
   
  
   
}
