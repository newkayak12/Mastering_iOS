import UIKit

class FifthViewController: UIViewController {
    
    @IBAction func popToRoot(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func popToThird(_ sender: Any) {
        guard let thirdVC = navigationController?.viewControllers.first(where: { $0 is
                ThirdViewController
        }) else {return}
        navigationController?.popToViewController(thirdVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}


























