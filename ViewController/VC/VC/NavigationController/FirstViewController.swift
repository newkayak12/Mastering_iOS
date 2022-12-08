
import UIKit

class FirstViewController: UIViewController {
    
    @IBAction func pushSecond(_ sender: Any) {
        guard let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") else {return}
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

























