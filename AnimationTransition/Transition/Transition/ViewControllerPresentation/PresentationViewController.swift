import UIKit

class PresentationViewController: UIViewController {
   
   @IBAction func unwindToHere(_ sender: UIStoryboardSegue) {      
   }
   
   @IBAction func present(_ sender: Any) {
       guard let modalVC = storyboard?.instantiateViewController(withIdentifier: "ModalViewController") else { return }
       present(modalVC, animated: true, completion: nil) //<-> dismiss
       
//       show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)   // <->
   //stack 쌓으며 넘어감 (pushSegue)
   //container에 embedded 되어 있다면 해당 container에 embed
   //container 가 없다면 modal로
       
//       showDetailViewController(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
   //splitView에 embed 되었있다면 detailView에 표시하는 것 이외에는 같다.
       
       
       
       
   }
}















