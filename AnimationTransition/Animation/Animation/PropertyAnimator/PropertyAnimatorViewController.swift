import UIKit

class PropertyAnimatorViewController: UIViewController {
   
   @IBOutlet weak var redView: UIView!
   
   var animator: UIViewPropertyAnimator?
   
   func moveAndResize() {
      let targetFrame = CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200)
      redView.frame = targetFrame
   }
   
   @IBAction func reset(_ sender: Any?) {
      redView.backgroundColor = UIColor.red
      redView.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
   }
   
   @IBAction func pause(_ sender: Any) {
       animator?.pauseAnimation()
       print(animator?.fractionComplete)
   }
   
   @IBAction func animate(_ sender: Any) {
//         animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 7, delay: 0, options: []) {
//           self.moveAndResize()
//       } completion: { position in
//           switch position {
//               case .start:
//                   print("Start")
//               case .end:
//                   print("End")
//               case .current:
//                   print("Current")
//           }
//       }
       
       animator = UIViewPropertyAnimator(duration: 7, curve: .linear, animations: {
           self.moveAndResize()
       })
       
       animator?.addCompletion({ position in
           print("DONE \(position)")
       })

   }
   
   @IBAction func resume(_ sender: Any) {
       animator?.startAnimation()
   }
   
   @IBAction func stop(_ sender: Any) {
       animator?.stopAnimation(false) //stopped 상태로 전환
       animator?.finishAnimation(at: .current) //이러면 completionHandler가 호출되고 inactive가 됨
   }
   
   @IBAction func add(_ sender: Any) {
       animator?.addAnimations({ //stopped상태 -> crash ,, inactive, active 상태일 때만 호출해야
           self.redView.backgroundColor = UIColor.blue
       }, delayFactor: 0)
       
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }   
}
