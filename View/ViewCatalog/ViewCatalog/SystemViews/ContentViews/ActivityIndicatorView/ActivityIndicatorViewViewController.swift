import UIKit

class ActivityIndicatorViewViewController: UIViewController {
    
    
    @IBOutlet weak var hiddenSwitch: UISwitch!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBAction func toggleHidden(_ sender: UISwitch) {
        loader.hidesWhenStopped = sender.isOn
    }
    
    @IBAction func start(_ sender: Any) {
        if !loader.isAnimating{
            loader.startAnimating()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if loader.isAnimating {
            loader.stopAnimating()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenSwitch.isOn = loader.hidesWhenStopped
        loader.startAnimating();
        
    }
}
