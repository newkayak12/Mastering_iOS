
import UIKit

class InteractiveAnimationViewController: UIViewController {
   
   @IBOutlet weak var redView: UIView!
   
   var animator: UIViewPropertyAnimator?
   
   func moveAndResize() {
      let targetFrame = CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200)
      redView.frame = targetFrame
      redView.backgroundColor = UIColor.blue
   }
   
   @IBAction func animate(_ sender: Any) {
      animator?.startAnimation()
   }
   
   @IBAction func sliderChanged(_ sender: UISlider) {
       animator?.fractionComplete //실행된 애니메이션의 상태를 보여줌
       = CGFloat(sender.value) //이러면 propertyAnimator가 알아서 실행 상태 계산함
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      animator = UIViewPropertyAnimator(duration: 7, curve: .linear, animations: {
         self.moveAndResize()
      })
   }
}
