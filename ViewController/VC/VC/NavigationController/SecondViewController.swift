import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func pop(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func pushThird(_ sender: Any) {
        guard let thirdVC = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") else {return}
        navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    
    @objc func addRightButtons() {
        let btn1 = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        let btn2 = UIBarButtonItem(title: "Two", style: .plain, target: nil, action: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}


























