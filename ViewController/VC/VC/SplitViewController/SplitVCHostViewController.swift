import UIKit

class SplitVCHostViewController: UIViewController {
    @IBAction func presentSplitViewController(_ sender: Any) {
        guard let masterView = storyboard?.instantiateViewController(withIdentifier: "ColorListTableViewController") else { return }
        let nav = UINavigationController(rootViewController: masterView)
        
        
        guard let detailVeiw = storyboard?.instantiateViewController(withIdentifier: "ColorDetailViewController") else {return}
        let splitView = CustomSplitViewController()
        splitView.viewControllers = [nav, detailVeiw]
        
        present(splitView, animated: true)
    }
    
    
    @IBAction func unwindToSplitHost(_ sender: UIStoryboardSegue) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CustomSplitViewController {
            vc.setupDefaultValue()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




























