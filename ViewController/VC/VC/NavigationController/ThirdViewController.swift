import UIKit

class ThirdViewController: UIViewController {
    
    @IBAction func pushForuth(_ sender: Any) {
        guard let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthViewController") else { return }
        navigationController?.pushViewController(fourthVC, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




























