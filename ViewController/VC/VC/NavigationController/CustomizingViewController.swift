
import UIKit

class CustomizingViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        
        standard.backgroundColor = .systemYellow
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
    }
}























