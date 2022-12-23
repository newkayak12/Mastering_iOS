import UIKit

class MinimumLayoutMarginsViewController: UIViewController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(systemMinimumLayoutMargins)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRespectsSystemMinimumLayoutMargins = false
        
    }
}
