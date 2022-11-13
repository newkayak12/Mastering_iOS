import UIKit

class SwitchViewController: UIViewController {
    
    @IBOutlet weak var bulbImageView: UIImageView!
    @IBOutlet weak var testSwitch: UISwitch!
    
    @IBAction func stateChanged(_ sender: UISwitch) {
        bulbImageView.isHighlighted = sender.isOn
    }
    
    @IBAction func toggle(_ sender: Any) {
//        testSwitch.isOn.toggle()
        //코드로 바꾸면 액션실행 X
        
        testSwitch.setOn(!testSwitch.isOn, animated: true)
        stateChanged(testSwitch)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testSwitch.isOn = bulbImageView.isHighlighted
    }
}
