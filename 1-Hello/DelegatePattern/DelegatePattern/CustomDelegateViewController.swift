import UIKit

class CustomDelegateViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    
    
    @objc func presentComposeVC() {
        performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? ComposeViewController {
            vc.delegate = self;
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentComposeVC))
    }
}

extension CustomDelegateViewController: ComposeDelegate {
    func composer(_ vc: UIViewController, didInput value: String?) {
        valueLabel.text = value
    }
    func composerDidCancel(_ vc: UIViewController) {
        valueLabel.text = "Cancel"
    }
}






























