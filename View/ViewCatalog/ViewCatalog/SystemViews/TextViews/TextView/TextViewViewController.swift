import UIKit

class TextViewViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainerInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)//scrollIndicator도 따로 지정해야함
        textView.scrollIndicatorInsets = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)//scrollIndicator도 따로 지정해야함
        
    }
}
