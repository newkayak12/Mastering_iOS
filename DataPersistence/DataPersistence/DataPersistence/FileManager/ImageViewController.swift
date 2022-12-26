import UIKit

class ImageViewController: UIViewController {
   
   var url: URL?
   
   @IBOutlet weak var imageView: UIImageView!
   
   @IBAction func close(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
       
       if let url = url, let data = try? Data(contentsOf: url) {
           imageView.image = UIImage(data: data)
           
           navigationItem.title = url.lastPathComponent
       }
      
   }
}
