import UIKit

class CGColorCIColorViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.layer.borderWidth = 10
        //CI는 주로 필터 만들 떄 씀
        blueView.layer.borderColor = UIColor.yellow.cgColor
        /**
         CG, CI, UI 컬러
         UIColor(cgColor: <#T##CGColor#>)
         UIColor(ciColor: <#T##CIColor#>)
         */
        
    }
}
