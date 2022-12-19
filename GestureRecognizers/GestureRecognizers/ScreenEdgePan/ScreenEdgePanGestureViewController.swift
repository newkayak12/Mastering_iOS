import UIKit

class ScreenEdgePanGestureViewController: UIViewController {
   
   @IBOutlet weak var containerView: UIView!
   @IBOutlet weak var redView: UIView!
   @IBOutlet weak var blueView: UIView!
   
   
    @IBAction func edgeBottomHander(_ sender: UIScreenEdgePanGestureRecognizer) {

            print("??")
        if sender.state == .ended {
            UIView.transition(with: containerView, duration: 1, options: [.transitionFlipFromBottom]) {
                self.redView.isHidden = !self.redView.isHidden
                self.blueView.isHidden = !self.blueView.isHidden
            }
        }
    }
    @IBAction func edgePanHandler(_ sender: UIScreenEdgePanGestureRecognizer) {
        if sender.state == .ended {
            UIView.transition(with: containerView, duration: 1, options: [.transitionFlipFromRight]) {
                self.redView.isHidden = !self.redView.isHidden
                self.blueView.isHidden = !self.blueView.isHidden
            }
        }
    }
    
   override func viewDidLoad() {
      super.viewDidLoad()
      
      redView.isHidden = true
      blueView.isHidden = false
       
       navigationController?.interactivePopGestureRecognizer?.isEnabled = false
   }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return UIRectEdge.all
    }
   
}
