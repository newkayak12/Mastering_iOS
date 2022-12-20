
import UIKit

class FirstViewController: UIViewController {
    @IBAction func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {
        print(#function, type(of: unwindSegue.source), "=>", type(of: unwindSegue.destination))
        let sourceViewController = unwindSegue.source
    }
    
    override func canPerformUnwindSegueAction(_ action: Selector, from fromViewController: UIViewController, sender: Any?) -> Bool {
        print(type(of: self), #function)
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}


















