import UIKit

class PresentationStyleViewController: UIViewController {
   
   @IBAction func present(_ sender: UIButton) {
      let sb = UIStoryboard(name: "Presentation", bundle: nil)
      let modalVC = sb.instantiateViewController(withIdentifier: "ModalViewController")
      
       let style = UIModalPresentationStyle(rawValue: sender.tag) ?? .fullScreen
       modalVC.modalPresentationStyle = style
       
       if let pc = modalVC.popoverPresentationController {
           pc.sourceView = sender
           modalVC.preferredContentSize = CGSize(width: 500, height: 300)
       }
      printPresentationStyle(for: modalVC)
      present(modalVC, animated: true, completion: nil)
   }
   

   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      print(String(describing: type(of: self)), #function)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      print(String(describing: type(of: self)), #function)
   }
}


extension PresentationStyleViewController {
   func printPresentationStyle(for vc: UIViewController) {
      print("\n\n============== ", separator: "", terminator: "")
      
      switch vc.modalPresentationStyle {
      case .fullScreen:
              //presenting view controller를 제거, 추가
         print("Full Screen")
      case .pageSheet:
              //ipad에서 유효 넓은 크기의 모달
         print("Page Sheet")
      case .formSheet:
              //일반적인 모달
         print("Form Sheet")
      case .currentContext:
         print("Current Sheet")
      case .overFullScreen:
              //presenting view controller를 제거, 추가 X
         print("Over Full Screen")
      case .overCurrentContext:
              //presenting view controller를 제거, 추가 X
         print("Over Current Context")
      case .popover:
              //iPad에서는 barbutton등이 있어야
         print("Popover")
      default:
         print("")
      }
   }
}
