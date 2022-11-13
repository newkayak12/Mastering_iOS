import UIKit

class SimpleSliderViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBAction func sliderChanged(_ sender: Any) {
        let r = CGFloat( redSlider.value )
        let g = CGFloat( greenSlider.value )
        let b = CGFloat( blueSlider.value )
        let color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        view.backgroundColor = color
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redSlider.value = 1.0
        redSlider.maximumValue = 1.0
        redSlider.minimumValue = 0.0
        greenSlider.value = 1
        greenSlider.maximumValue = 1.0
        greenSlider.minimumValue = 0.0
        blueSlider.value = 1
        blueSlider.maximumValue = 1.0
        blueSlider.minimumValue = 0.0
        
//        redSlider.setValue(1, animated: true)
        
    }
}
