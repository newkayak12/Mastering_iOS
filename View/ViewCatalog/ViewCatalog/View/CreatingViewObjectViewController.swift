import UIKit

class CreatingViewObjectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        let v = UIView(frame: frame)
        v.backgroundColor = UIColor.systemBlue
        view.addSubview(v) //view == rootView
        
    }
}
