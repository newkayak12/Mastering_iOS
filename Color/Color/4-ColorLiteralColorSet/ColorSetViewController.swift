import UIKit

class ColorSetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //colorLiteral 없음
//        let c = UIColor.blue
        let color = UIColor(named: "PrimaryColor") ?? UIColor.white
        view.backgroundColor = color
        
    }
}
