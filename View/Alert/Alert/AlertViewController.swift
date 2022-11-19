import UIKit

class AlertViewController: UIViewController {
    
    @IBAction func show(_ sender: Any) {
        let controller = UIAlertController(title: "HELLO", message: "Have a nice day :)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print(action.title)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print(action.title)
        }
        controller.addAction(cancelAction)
        //style cancel이 왼쪽으로 감
        let destructiveAction = UIAlertAction(title: "Destructive", style: .destructive) { action in
            print(action.title)
        }
        controller.addAction(destructiveAction)
        controller.preferredAction = okAction
        //preferredAction 은 순서가 중요함
        //만약 action에 없는 액션을 preferred로 설정하면 crash가 된다. 
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}










































