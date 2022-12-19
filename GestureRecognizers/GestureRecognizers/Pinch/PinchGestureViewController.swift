import UIKit

class PinchGestureViewController: UIViewController {
   
   @IBOutlet weak var imageView: UIImageView!
   
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        
        guard let targetView = sender.view else {
            return
        }
        
        targetView.transform = targetView.transform.scaledBy(x: sender.scale, y: sender.scale)
                
        
        sender.scale = 1
        print(sender.scale)
        if sender.state.rawValue == 3 {
            UIView.animate(withDuration: 0.3) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }
    }
    
   
   @IBAction func reset(_ sender: Any) {
       UIView.animate(withDuration: 0.3) {
           self.imageView.transform = CGAffineTransform.identity
       }
   }

}
