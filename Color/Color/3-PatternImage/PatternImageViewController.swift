import UIKit

class PatternImageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = UIImage(named: "pattern"){
            let patternColor = UIColor(patternImage: img) //이미지를 패턴으로 표시
            view.backgroundColor = patternColor
        }
        
    }
}
