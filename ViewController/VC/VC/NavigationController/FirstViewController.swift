
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
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftButton
        
        let titleButton = UIBarButtonItem(title: "Action", style: .done, target: nil, action: nil)
        let toggleSwitch = UISwitch(frame: .zero)
        let switchButton = UIBarButtonItem(customView: toggleSwitch)
        navigationItem.rightBarButtonItems = [switchButton, titleButton]
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Go Back", style: .plain, target: nil, action: nil)
    }
    
}

























