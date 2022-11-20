
import UIKit

class SpellCheckingViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func spellCheckingChanged(_ sender: UISegmentedControl) {
        textView.spellCheckingType = UITextSpellCheckingType(rawValue:  sender.selectedSegmentIndex) ?? .default
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
