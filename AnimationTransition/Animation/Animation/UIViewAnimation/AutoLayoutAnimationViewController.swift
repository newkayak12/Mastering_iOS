import UIKit

class AutoLayoutAnimationViewController: UIViewController {

   @IBOutlet weak var redView: UIView!
   
   @IBOutlet weak var widthConstraint: NSLayoutConstraint!

   @IBOutlet weak var heightConstraint: NSLayoutConstraint!
   
   @IBAction func animate(_ sender: Any) {
//      let targetFrame = CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200)
//
//      UIView.animate(withDuration: 0.3) {
//         self.redView.frame = targetFrame
//      }
       self.widthConstraint.constant = 200;
       self.heightConstraint.constant = 200;
//애니메이션 시작하기 전에 제약 업데이트 후
       
       //만약 아래 애니메이션 적용 안된다면??
       redView.setNeedsUpdateConstraints()
       UIView.animate(withDuration: 0.3) {
           self.view.layoutIfNeeded() //실행
       }
   }
}













