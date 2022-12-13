import UIKit

class TransitionStyleViewController: UIViewController {
   
   var selectedTransitionStyle = UIModalTransitionStyle.coverVertical
   
   @IBAction func styleChanged(_ sender: UISegmentedControl) {
      selectedTransitionStyle = UIModalTransitionStyle(rawValue: sender.selectedSegmentIndex) ?? .coverVertical
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       let presentedVC = segue.destination
       presentedVC.modalTransitionStyle = selectedTransitionStyle
   }
   
   
   @IBAction func present(_ sender: Any) {
      let sb = UIStoryboard(name: "Presentation", bundle: nil)
      let modalVC = sb.instantiateViewController(withIdentifier: "ModalViewController")
       modalVC.modalTransitionStyle = selectedTransitionStyle
      
      present(modalVC, animated: true, completion: nil)
   }
}

















