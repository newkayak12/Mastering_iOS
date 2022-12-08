import UIKit

class FourthViewController: UIViewController {
    
    @IBAction func pushFifth(_ sender: Any) {
        guard let fifthVC = storyboard?.instantiateViewController(withIdentifier: "FifthViewController") else { return }
        navigationController?.pushViewController(fifthVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}






























