

import UIKit

class ProgressViewViewController: UIViewController {
    
    @IBOutlet weak var progress: UIProgressView!
    @IBAction func update(_ sender: Any) {
//        progress.progress = 0.8
        progress.setProgress(0.8, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.progress = 0.0
        progress.trackTintColor = .systemGray3
        progress.progressTintColor = .systemRed
    }
}
