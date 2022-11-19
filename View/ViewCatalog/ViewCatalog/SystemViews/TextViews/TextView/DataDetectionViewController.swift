
import UIKit

class DataDetectionViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.dataDetectorTypes = [.link, .address, .phoneNumber]
        
    }
}



