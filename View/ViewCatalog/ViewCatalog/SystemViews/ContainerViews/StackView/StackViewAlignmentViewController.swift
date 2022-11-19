import UIKit

class StackViewAlignmentViewController: UIViewController {
    
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBAction func alignmentChanged(_ sender: UISegmentedControl) {
        let options: [UIStackView.Alignment] = [.fill, .top
                                                , .center, .bottom]
        UIView.animate(withDuration: 0.3) {
            self.horizontalStackView.alignment = options[sender.selectedSegmentIndex]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}















