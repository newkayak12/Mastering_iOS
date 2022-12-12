
import UIKit

class MotionEffectViewController: UIViewController {
   /**
    UIInterpolationMotionEffect
    UIMotionEffectGroup : 모션 이펙트 그룹
    UIMotionEffect가 위 클래스 들의 상위임
    */
   @IBOutlet weak var targetImageView: UIImageView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       let x = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
       x.minimumRelativeValue = -100
       x.maximumRelativeValue = 100
       
       let y = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
       y.minimumRelativeValue  = -100
       x.maximumRelativeValue = 100
       
       let group = UIMotionEffectGroup()
       group.motionEffects = [x,y]
       targetImageView.addMotionEffect(group)
   }
}















