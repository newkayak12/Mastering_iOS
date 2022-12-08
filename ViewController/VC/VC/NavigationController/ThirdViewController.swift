import UIKit

class ThirdViewController: UIViewController {
    
    @IBAction func unwindToThird(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    @IBAction func pushForuth(_ sender: Any) {
        guard let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthViewController") else { return }
        navigationController?.pushViewController(fourthVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




























