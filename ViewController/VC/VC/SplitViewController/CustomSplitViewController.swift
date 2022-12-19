import UIKit

class CustomSplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        preferredDisplayMode = .automatic
    }
    
    
    func setupDefaultValue() {
        guard let nav = viewControllers.first as? UINavigationController, let masterVC = nav.viewControllers.first as? ColorListTableViewController else {return }
        
        guard let detail = viewControllers.last as? ColorDetailViewController else { return }
        
        print(#function , masterVC.list.first)
        detail.color = masterVC.list.first
    }
}



extension CustomSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

























