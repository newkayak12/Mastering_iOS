
import UIKit

class TextButtonViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        btn.titleLabel?.text = "Hello" //이렇게 직접 바꾸는거 허락하지 않음
//        btn.titleLabel?.textColor = .red //이렇게 직접 바꾸는거 허락하지 않음
        btn.setTitle("Hello", for: .normal)
        btn.setTitle("haha", for: .highlighted)
        btn.setTitleColor(.systemRed, for: .normal)
        btn.titleLabel?.backgroundColor = .yellow
        
    }
}
