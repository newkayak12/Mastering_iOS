

import UIKit

class IdentifierViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leading = blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        leading.identifier = "codeLeading"
        leading.isActive = true
    }
}
