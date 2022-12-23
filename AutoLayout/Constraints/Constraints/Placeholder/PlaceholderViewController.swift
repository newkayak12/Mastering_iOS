
import UIKit

class PlaceholderViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var listTableView: UITableView!
    
    let source = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.".components(separatedBy: " ").filter { $0.trimmingCharacters(in: .whitespaces).count > 1 }
    
    lazy var list = source {
        didSet {
            emptyView.isHidden = list.count > 0
        }
    }
    
    @IBAction func fill(_ sender: Any) {
        list = source
        listTableView.reloadData()
    }
    
    @IBAction func empty(_ sender: Any) {
        list = []
        listTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emptyView.isHidden = true
    }
}



extension PlaceholderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}
