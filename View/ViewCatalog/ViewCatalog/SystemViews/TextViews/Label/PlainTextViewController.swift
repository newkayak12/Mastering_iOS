import UIKit

class PlainTextViewController: UIViewController {
    
    
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var fontSizeStepper: UIStepper!
    
    
    
    @IBAction func changeColorToRed(_ sender: Any) {
        valueLabel.textColor = UIColor.systemRed
    }
    
    @IBAction func changeColorToBlue(_ sender: Any) {
        valueLabel.textColor = UIColor.systemBlue
    }
    
    @IBAction func changeColorToBlack(_ sender: Any) {
        valueLabel.textColor = UIColor.black
    }
    
    
    
    
    @IBAction func updateAlignment(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        guard let alignment = NSTextAlignment(rawValue: selectedIndex) else {
            return
        }
        valueLabel.textAlignment = alignment
                
    }
    
    
    
    
    @IBAction func updateFontSize(_ sender: UIStepper) {
        let newSize = CGFloat(sender.value)
        let newFont  = valueLabel.font.withSize(newSize)
        valueLabel.font = newFont
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fontSizeStepper.value = Double(valueLabel.font.pointSize)
    }
}
