import UIKit

class RotationGestureViewController: UIViewController {
   
   @IBOutlet weak var imageView: UIImageView!
   
   
    @IBAction func rotationHandler(_ sender: UIRotationGestureRecognizer) {
        
        guard let targetView = sender.view else {
            return
        }
        targetView.transform = targetView.transform.rotated(by: sender.rotation)
        
        sender.rotation = 0 //회전이 계속 누적되는 것을 막음
    }
    
   @IBAction func reset(_ sender: Any) {
       UIView.animate(withDuration: 0.3) {
           self.imageView.transform = CGAffineTransform.identity
       }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       imageView.isUserInteractionEnabled = true
   }
}
