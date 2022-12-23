import UIKit

class LayoutMarginViewController: UIViewController {

    @IBOutlet weak var yellowView: UIView!
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("RootView : \(view.directionalLayoutMargins)") //iOS 11 later leading/trailling
        print("RootView : \(view.layoutMargins)")//left, right
        print("🟨 : \(yellowView.directionalLayoutMargins)")
        print("🟨 : \(yellowView.layoutMargins)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
