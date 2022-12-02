import UIKit

class ReorderingViewController: UIViewController {
    
    var firstList = [String]()
    var secondList = [String]()
    var thirdList = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPad", "iPad mini", "iPhone 8", "iPhone 8 Plus", "iPhone SE", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    @objc func reloadTableView() {
        listTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.setEditing(true, animated: false)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(reloadTableView))
    }
}




extension ReorderingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return firstList.count
        case 1:
            return secondList.count
        case 2:
            return thirdList.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = firstList[indexPath.row]
        case 1:
            cell.textLabel?.text = secondList[indexPath.row]
        case 2:
            cell.textLabel?.text = thirdList[indexPath.row]
        default:
            break
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "First Section"
        case 1:
            return "Second Section"
        case 2:
            return "Third Section"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var target: String? = nil
        switch sourceIndexPath.section {
            case 0:
                target = firstList.remove(at: sourceIndexPath.row)
            case 1:
                target = secondList.remove(at: sourceIndexPath.row)
            case 2:
                target = thirdList.remove(at: sourceIndexPath.row)
            default:
                break;
        }
        guard let item = target else {return }
        switch destinationIndexPath.section {
            case 0:
                firstList.insert(item, at: destinationIndexPath.row)
            case 1:
                secondList.insert(item, at: destinationIndexPath.row)
            case 2:
                thirdList.insert(item, at: destinationIndexPath.row)
            default:
                break;
                
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}




extension ReorderingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.section == 0 {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
}














