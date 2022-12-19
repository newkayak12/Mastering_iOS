import UIKit

class SwipeGestureViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
   
    @IBAction func swipeUpHandler(_ sender: UISwipeGestureRecognizer) {
        
        print("UP")
//        print(sender.state)
        if sender.state == .ended {
            guard let modal = storyboard?.instantiateViewController(withIdentifier: "modal") else  {
                return
            }
            present(modal, animated: true)
        }
    }
}
