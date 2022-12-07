import UIKit

class ContainerViewController: UIViewController {
    
    
    @IBOutlet weak var bottomContainerView: UIView!
    
    @objc func removeChild() {
        for vc in childViewControllers {
            vc.willMove(toParentViewController: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParentViewController()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let childVC = storyboard?.instantiateViewController(withIdentifier: "BottomViewController"){
            addChildViewController(childVC) //CHILD로 추가하고
            childVC.didMove(toParentViewController: self)
            childVC.view.frame = bottomContainerView.bounds //rootview에 추가
            bottomContainerView.addSubview(childVC.view)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeChild))
        
    }
}



extension ContainerViewController {
    override var description: String {
        return String(describing: type(of: self))
    }
}




















