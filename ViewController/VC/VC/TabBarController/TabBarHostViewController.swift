
import UIKit

class TabBarHostViewController: UIViewController {
    
    @IBAction func presentTabBarController(_ sender: Any) {
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "FirstTabViewController")
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondTabViewController")
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .systemYellow
        thirdVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "3.circle"), tag: 0)
        
        let tbc = UITabBarController()
        tbc.viewControllers = [firstVC!, secondVC!, thirdVC]
        
        present(tbc, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
