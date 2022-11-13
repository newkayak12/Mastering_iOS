import UIKit

class CustomSliderViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(systemName: "lightbulb")
        
        slider.setThumbImage(img, for: .normal)
        slider.minimumTrackTintColor = UIColor.systemRed
        slider.maximumTrackTintColor = UIColor.black
        
//        slider.thumbTintColor = UIColor.blue
//        slider.setMinimumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//        slider.setMaximumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
    }
}
