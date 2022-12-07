import UIKit

class BottomViewController: UIViewController {
    
    @IBAction func removeFromParent(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {//추가되거나 삭제되기 전
        super.willMove(toParentViewController: parent)
        print(self, #function, parent?.description ?? "nil")
    }
    override func didMove(toParentViewController parent: UIViewController?) {//추가되거나 삭제된 후
        super.didMove(toParentViewController: parent)
        print(self, #function, parent?.description ?? "nil")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}













