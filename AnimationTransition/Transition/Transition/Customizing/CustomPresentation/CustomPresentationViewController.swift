import UIKit

class CustomPresentationViewController: UIViewController {
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       segue.destination.modalPresentationStyle = .custom
       segue.destination.transitioningDelegate = self
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
}


extension CustomPresentationViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SimplePresentationController(presentedViewController: presented, presenting: presenting)
    }
}















