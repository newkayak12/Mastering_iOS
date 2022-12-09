
import UIKit

class CustomStatusBarStyleNavigationController: UINavigationController {
    override var childViewControllerForStatusBarHidden: UIViewController?{
        return topViewController
    }
    override var childViewControllerForStatusBarStyle: UIViewController?{
        return topViewController
    }
    //이러면 child가 statusbar를 컨트롤 할 수 있음
    // 이 이전은 root가 navigator라 불가능
}
