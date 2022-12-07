import UIKit

class CustomInterfaceOrientationController: UINavigationController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return [.landscapeLeft, .landscapeRight]
    }
}


















