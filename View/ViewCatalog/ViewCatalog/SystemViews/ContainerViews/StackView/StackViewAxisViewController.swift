
import UIKit

class StackViewAxisViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBAction func toggleAxis(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { [self] in
            if stackView.axis == .horizontal {
                stackView.axis = .vertical
            } else {
                stackView.axis = .horizontal
            }
        }
        
        //배치와 관련된 것은 UIAnimation을 지원
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
