import UIKit

class SimpleUIViewAnimationViewController: UIViewController {
   
   @IBOutlet weak var redView: UIView!
   
   @IBAction func reset(_ sender: Any?) {
      redView.backgroundColor = UIColor.red
      redView.alpha = 1.0
      redView.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
   }
   
   @IBAction func animate(_ sender: Any) {
       var frame = redView.frame
       frame.origin = view.center
       frame.size = CGSize(width: 100, height: 100)
//       UIView.animate(withDuration: 3) {
//           self.redView.frame = frame
//
//           self.redView.alpha = 0.5
//           self.redView.backgroundColor = UIColor.blue
//       }
           UIView.animate(withDuration: 3) {
               self.redView.frame = frame
               self.redView.alpha = 0.5
               self.redView.backgroundColor = UIColor.blue
           } completion: { finished in
               //여기는 애니메이션 X
//               self.reset(nil)
//               그러면 reset에 animate걸어야함
               UIView.animate(withDuration: 3) {
                    self.reset(nil)   
               }
               
           }

       
       
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      reset(nil)
   }
}





















