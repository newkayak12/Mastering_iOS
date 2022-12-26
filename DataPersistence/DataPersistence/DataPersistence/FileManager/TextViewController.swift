import UIKit

class TextViewController: UIViewController {
   
   var url: URL?
   
   @IBOutlet weak var textView: UITextView!
   
   @IBAction func close(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
        
       if let url = url {
           textView.text = try? String(contentsOf: url)
       }
       
       navigationItem.title = url?.lastPathComponent
      
   }
}
