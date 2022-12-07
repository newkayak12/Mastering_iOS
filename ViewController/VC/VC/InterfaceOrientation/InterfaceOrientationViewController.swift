import UIKit

class InterfaceOrientationViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        //cardModal, navigationController 역시 이전 것 유지
        return [.landscapeLeft, .landscapeRight]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
