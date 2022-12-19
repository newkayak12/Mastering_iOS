import UIKit

class TapGestureViewController: UIViewController {
   
   var count = 0
   
   @IBOutlet weak var countLabel: UILabel!
   
    @IBAction func handleTab(_ sender: UITapGestureRecognizer) {
        
        
        if sender.state == .ended {
            count += 1
            countLabel.text = "\(count)"
        }
        
    }
    override func viewDidLoad() {
      super.viewDidLoad()
      
      countLabel.text = "\(count)"
   }
   
   
   
}
