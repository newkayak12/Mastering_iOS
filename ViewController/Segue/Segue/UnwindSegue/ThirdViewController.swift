import UIKit

class ThirdViewController: UIViewController {
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print(type(of: self), #function)
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(type(of: self), #function)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print(type(of: self), #function)
    }
}
























