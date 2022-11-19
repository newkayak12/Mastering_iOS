import UIKit

class ResizableImageViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    let btnImage = UIImage(named: "btn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = btnImage {
            let capInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
            let bkgImage = img.resizableImage(withCapInsets: capInset, resizingMode: .stretch)
            btn.setBackgroundImage(bkgImage, for: .normal)
        }
        
    }
}
