import UIKit

class ImageViewController: UIViewController {
   
   @IBOutlet weak var imageView: UIImageView!
   
   var image: UIImage?
   
   @IBOutlet weak var topConstraint: NSLayoutConstraint!
   
    func showCloseButton() {
        topConstraint.constant = -40
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
   @IBAction func dismiss(_ sender: Any) {
//      dismiss(animated: true, completion: nil)
       
       topConstraint.constant = -100
       UIView.animate(withDuration: 0.3) {
           self.view.layoutIfNeeded()
       } completion: { finished in
           self.dismiss(animated: true, completion: nil)
       }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       topConstraint.constant = -100
      imageView.image = image
   }
}
