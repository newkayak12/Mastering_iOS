import UIKit

class TapCodeViewController: UIViewController {
   
   var count = 0
    var tapGesture: UITapGestureRecognizer?
    
   @IBOutlet weak var countLabel: UILabel!
   
    @objc func handleTab(_ tab: UITapGestureRecognizer){
        if tab.state == .ended {
            count += 1
            countLabel.text = "\(count)"
        }
    }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       countLabel.text = "\(count)"
       countLabel.isUserInteractionEnabled = true
       tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTab(_:)))
       
       tapGesture?.numberOfTapsRequired = 1
       tapGesture?.numberOfTouchesRequired = 1
       
       countLabel.addGestureRecognizer(tapGesture!)
      
      
   }
}
