
import UIKit

class ActionSheetViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func show(_ sender: UIButton) {
        let controller = UIAlertController(title: "Languages", message: "Choose one", preferredStyle: .actionSheet)
        
        let swiftAction = UIAlertAction(title: "Swift", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(swiftAction)
        
        let javaAction = UIAlertAction(title: "Java", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(javaAction)
        
        let pythonAction = UIAlertAction(title: "Python", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(pythonAction)
        
        let cSharpAction = UIAlertAction(title: "C#", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(cSharpAction)
        
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { [weak self] (action) in
            self?.resultLabel.text = nil
        }
        controller.addAction(clearAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        if let pc = controller.popoverPresentationController{ //이러면 cancelStyle이 안보임
            //pc.barButtonItem
            pc.sourceView = view
            pc.sourceRect = sender.frame
        }
        
        for action in controller.actions {
            if action.title == resultLabel.text {
                action.isEnabled = false
            }
        }
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}



















