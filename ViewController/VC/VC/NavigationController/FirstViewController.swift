
import UIKit

class FirstViewController: UIViewController {
    
    @IBAction func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func pushSecond(_ sender: Any) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") else {return}
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

























