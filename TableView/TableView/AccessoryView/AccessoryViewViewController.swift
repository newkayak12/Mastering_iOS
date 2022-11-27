import UIKit

class AccessoryViewViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    @objc func toggleEditMode() {
        listTableView.setEditing(!listTableView.isEditing, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleEditMode))
    }
}



extension AccessoryViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 4 {
            return tableView.dequeueReusableCell(withIdentifier:"customCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Disclosure Indicator"
                cell.accessoryType = .disclosureIndicator
            case 1:
                cell.textLabel?.text = "Detail Button"
                cell.accessoryType = .detailButton
            case 2:
                cell.textLabel?.text = "Detail Disclosure Button"
                cell.accessoryType = .detailDisclosureButton
            case 3:
                cell.textLabel?.text = "Checkmark"
                cell.accessoryType = .checkmark
            default:
                cell.textLabel?.text = "None"
                cell.accessoryType = .none
                
        }
        return cell
    }
}

extension AccessoryViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let accType =  tableView.cellForRow(at: indexPath)?.accessoryType {
            switch accType {
                case .disclosureIndicator, .detailDisclosureButton:
                    performSegue(withIdentifier: "pushSegue", sender: nil)
                case .detailButton:
                    performSegue(withIdentifier: "modalSegue", sender: nil)
                default:
                    break;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "modalSegue", sender: nil)
    }
}



















