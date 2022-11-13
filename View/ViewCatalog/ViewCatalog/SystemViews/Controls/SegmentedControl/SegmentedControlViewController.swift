import UIKit

class SegmentedControlViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var alignmentControl: UISegmentedControl!
    @IBOutlet weak var momentarySwitch: UISwitch!
    
    @IBAction func alignmentChanged(_ sender: UISegmentedControl) {
        label.textAlignment = NSTextAlignment(rawValue: sender.selectedSegmentIndex) ?? .center
    }
    @IBAction func toggleMomentary(_ sender: UISwitch) {
        alignmentControl.isMomentary = sender.isOn
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alignmentControl.selectedSegmentIndex = label.textAlignment.rawValue
        momentarySwitch.isOn = alignmentControl.isMomentary
        
        alignmentControl.setTitle("왼쪽", forSegmentAt: 0)
        alignmentControl.setTitle("중앙", forSegmentAt: 1)
        alignmentControl.setTitle("오른쪽", forSegmentAt: 2)
    }
}














