import UIKit

class TextSelectionViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var selectedRangeLabel: UILabel!
    
    @IBAction func selectLast(_ sender: Any) {
        let lastWord = "pariatur?"
        if let text = textView.text as NSString? {
            let range = text.range(of: lastWord)
            textView.selectedRange = range
            textView.scrollRangeToVisible(range)
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }
}
extension TextSelectionViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        let range = textView.selectedRange
        selectedRangeLabel.text = "\(range)"
    }
}

