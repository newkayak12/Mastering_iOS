
import UIKit

class SectionHeaderAndFooterViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = Region.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib(nibName: "CustomHeader", bundle: nil)
//        listTableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier:    "header")
        listTableView.register(headerNib, forHeaderFooterViewReuseIdentifier:    "header")
    }
}



extension SectionHeaderAndFooterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].countries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = list[indexPath.section].countries[indexPath.row]
        cell.textLabel?.text = target
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return list[section].title
//    }
}




extension SectionHeaderAndFooterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
//        headerView?.textLabel?.text = list[section].title
//        headerView?.detailTextLabel?.text = "lorem ipsum"
//        headerView?.backgroundColor = .secondarySystemFill
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CustomHeaderView
        headerView.titleLabel.text = list[section].title
        headerView.countLabel.text = "\(list[section].countries.count)"
       
        return headerView
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {//시각적 속성
//        if let headerView = view as? UITableViewHeaderFooterView{
//            headerView.textLabel?.textColor = .systemBlue
//            headerView.textLabel?.textAlignment = .center
//
//            if headerView.backgroundView == nil {
//                let v = UIView(frame: .zero)
//                v.backgroundColor = .secondarySystemFill
//                v.isUserInteractionEnabled = false
//                headerView.backgroundView = v
//            }
//        }
//    }
}














