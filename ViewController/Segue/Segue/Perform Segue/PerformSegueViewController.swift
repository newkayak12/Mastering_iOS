import UIKit

class PerformSegueViewController: UIViewController {
    
    
    @IBOutlet weak var grantedSwitch: UISwitch!
    
    
    @IBAction func perform(_ sender: Any) {
        performSegue(withIdentifier: "manualSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard  let  msgVC
                = segue.destination as? MessageViewController else {return}
        msgVC.segueName = segue.identifier
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "conditionalSegue" {
            return grantedSwitch.isOn
        }
        
        //destination X
        return true //true -> segue 실행, false -> 바로 종료
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




















