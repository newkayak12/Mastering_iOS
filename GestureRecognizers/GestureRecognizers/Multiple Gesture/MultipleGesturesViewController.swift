import UIKit

class MultipleGesturesViewController: UIViewController {
   
   @IBOutlet var pinchGesture: UIPinchGestureRecognizer!
   
   @IBOutlet var rotationGesture: UIRotationGestureRecognizer!
/// 제스쳐가 인식되는 순서를 정하고
/// 인식 순서가 정해지지 않으면 delegate
   @IBAction func handleRotationGesture(_ sender: UIRotationGestureRecognizer) {
      guard let targetView = sender.view else { return }
      
      targetView.transform =  targetView.transform.rotated(by: sender.rotation)
      sender.rotation = 0
   }
   
   @IBAction func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
      guard let targetView = sender.view else { return }
      
      targetView.transform = targetView.transform.scaledBy(x: sender.scale, y: sender.scale)
      sender.scale = 1
   }
   
    @IBAction func panHandler(_ sender: UIPanGestureRecognizer) {
        
        guard let targetView = sender.view else {return}
        
        let translation = sender.translation(in: view)
        targetView.center.x += translation.x
        targetView.center.y += translation.y
        
        sender.setTranslation(.zero, in: view)
    }
    
   override func viewDidLoad() {
      super.viewDidLoad()
//인식 순서 고정일 때
//       pinchGesture.require(toFail: rotationGesture) //rotate가 안되면 pinch
      
       
       
       pinchGesture.delegate = self
       rotationGesture.delegate = self
   }
}

extension MultipleGesturesViewController: UIGestureRecognizerDelegate{
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer == pinchGesture && otherGestureRecognizer == rotationGesture {
//            return true //rotate를 먼저 인식
//        }
//
//        return false
//    }
    
    //차라리 다른 방법을 찾는게 낫다고 한다. 결국 한 번에 한 개씩
    
    
    
    //모든 제스쳐를 동시에
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //동시에 true를 주면 동시 처리, 파리미터로 조율도 가능
        return true
    }
}
