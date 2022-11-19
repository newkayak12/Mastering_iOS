import UIKit

class UIColorViewController: UIViewController {
    
    @IBOutlet weak var targetView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let r = CGFloat(redSlider.value)
        let g = CGFloat(greenSlider.value)
        let b = CGFloat(blueSlider.value)
        
        targetView.backgroundColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        targetView.backgroundColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
        redSlider.value = Float(r)
        greenSlider.value = Float(g)
        blueSlider.value = Float(b)
        
/**
 UIColor(red: 29.0 / 255.0, green: 161.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
 
 
 //srgb
 
 UIColor(displayP3Red: 29.0 / 255.0, green: 161.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
 //displayP3
 
 //rgb 하나라도 바꾸려면 새로 만들어야함
 UIColor.systemRed.withAlphaComponent(0.5)
 UIColor.clear //투명도 0일때
 */
    }
}
