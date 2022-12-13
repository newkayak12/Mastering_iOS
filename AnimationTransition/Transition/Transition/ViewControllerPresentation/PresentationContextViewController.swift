import UIKit

class PresentationContextViewController: UIViewController {
   
   @IBAction func switchChanged(_ sender: UISwitch) {
       definesPresentationContext = sender.isOn
    
   }
}
