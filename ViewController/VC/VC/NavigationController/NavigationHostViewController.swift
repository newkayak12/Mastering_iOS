import UIKit

class NavigationHostViewController: UIViewController {
    
    @IBAction func presentNavigationController(_ sender: Any) {
        guard let rootVC = storyboard?.instantiateViewController(withIdentifier: "FirstViewController") else {return}
        let nav = UINavigationController(rootViewController: rootVC)
        present(nav, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




























