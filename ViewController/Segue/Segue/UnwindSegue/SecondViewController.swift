import UIKit

class SecondViewController: UIViewController {
    @IBAction func unwindToSecond(_ unwindSegue: UIStoryboardSegue) {
        print(#function, type(of: unwindSegue.source), "=>", type(of: unwindSegue.destination))
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




















