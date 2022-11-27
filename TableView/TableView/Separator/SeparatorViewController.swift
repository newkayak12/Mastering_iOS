import UIKit

class SeparatorViewController: UIViewController {
    
    let list = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.separatorStyle = .singleLine
        listTableView.separatorColor = .systemBlue
        listTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        listTableView.separatorInsetReference = .fromCellEdges
        
    }
}




extension SeparatorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print("\(indexPath.section) - \(indexPath.row)")
        if indexPath.row == 1{
            cell.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        } else if indexPath.row == 2 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        } else {
            cell.separatorInset = listTableView.separatorInset
        }
        cell.textLabel?.text = list[indexPath.row % list.count]
        return cell
    }
    
}
























