import UIKit

class ViewTransitionViewController: UIViewController {
   
   @IBOutlet weak var containerView: UIView!
   @IBOutlet weak var redView: UIView!
   @IBOutlet weak var blueView: UIView!
   
   @IBAction func startTransition(_ sender: Any) {
//       UIView.transition(with: containerView, duration: 1, options:[.transitionCurlUp], animations: {
//           self.redView.isHidden = !self.redView.isHidden
//           self.blueView.isHidden = !self.blueView.isHidden
//       }, completion: nil)
       
       UIView.transition(from: redView, to: blueView, duration: 1, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: {
           finished in
           UIView.transition(from: self.blueView, to: self.redView, duration: 1, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
       })

   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
       blueView.isHidden = false
      
   }
}
