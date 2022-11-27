import UIKit

class SelfSizingCellViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = [
        ("Always laugh when you can. It is cheap medicine.", "Lord Byron"),
        ("I probably hold the distinction of being one movie star who, by all laws of logic, should never have made it. At each stage of my career, I lacked the experience.", "Audrey Hepburn"),
        ("Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.", "Steve Jobs")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        listTableView.rowHeight = UITableViewAutomaticDimension
//        listTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
}



extension SelfSizingCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = list[indexPath.row]
        cell.textLabel?.text = target.0
        cell.detailTextLabel?.text = target.1
        return cell
    }
}



extension SelfSizingCellViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 100
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0 ){
            return 100
        }
        return UITableViewAutomaticDimension //평균 높이가 더 좋은 퍼포먼스
    }
}


























