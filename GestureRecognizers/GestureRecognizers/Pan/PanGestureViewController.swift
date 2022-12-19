import UIKit

class PanGestureViewController: UIViewController {
   
   @IBOutlet weak var redView: UIView!
   
   
    @IBAction func panHandler(_ sender: UIPanGestureRecognizer) {
        //began , changed, ended
        
        guard let targetView = sender.view else {
            return
        }
        let translation = sender.translation(in: view)
        //제스쳐 시작 시점에서부터
        /// 값이 누적됨
        
        
        targetView.center.x += translation.x
        targetView.center.y += translation.y
        
        sender.setTranslation(.zero, in: view)
    }
    
   override func viewDidLoad() {
      super.viewDidLoad()
      
      redView.layer.cornerRadius = 50
      redView.clipsToBounds = true
   }
}
