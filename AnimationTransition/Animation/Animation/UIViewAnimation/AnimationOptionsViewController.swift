

import UIKit

class AnimationOptionsViewController: UIViewController {   
   @IBOutlet weak var redView: UIView!
   
   @IBAction func reset(_ sender: Any?) {
      redView.backgroundColor = UIColor.red
      redView.alpha = 1.0
      redView.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
   }
   
   @IBAction func stop(_ sender: Any) {
       redView.layer.removeAllAnimations()
       reset(nil)
   }
   
   @IBAction func animate(_ sender: Any) {
      let animations: () -> () = {
         var frame = self.redView.frame
         frame.origin = self.view.center
         frame.size = CGSize(width: 100, height: 100)
         self.redView.frame = frame
         self.redView.alpha = 0.5
         self.redView.backgroundColor = UIColor.blue
      }
       
       UIView.animate(withDuration:1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: animations, completion: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      reset(nil)
   }
}












