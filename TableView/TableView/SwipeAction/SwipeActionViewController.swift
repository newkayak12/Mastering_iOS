import UIKit

class SwipeActionViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var list = [("Always laugh when you can. It is cheap medicine.", "Lord Byron"), ("I probably hold the distinction of being one movie star who, by all laws of logic, should never have made it. At each stage of my career, I lacked the experience.", "Audrey Hepburn"), ("Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.", "Steve Jobs")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



extension SwipeActionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].0
        cell.detailTextLabel?.text = list[indexPath.row].1
        
        return cell
    }
}



@available(iOS 11.0, *)
extension SwipeActionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //action, view, 마지막에 호출해야하는 클로저
        let unreadAction = UIContextualAction(style: .normal, title: "읽지 않음") { (action, view, complete) in
            
            complete(true)//제대로 움직이면 true
        }
        
        unreadAction.backgroundColor = .blue
        unreadAction.image = UIImage(systemName: "envelope")
        let configuration = UISwipeActionsConfiguration(actions: [unreadAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") {[weak self] (action, view, complete) in
            print("DELETE")
            self?.list.remove(at: indexPath.row)
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            complete(true)
        }
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        let flagAction = UIContextualAction(style: .normal, title: "깃발 표시") { (action, view, complete) in
            print("FLAG")
            complete(true)
        }
        flagAction.image = UIImage(systemName: "flag")
        flagAction.backgroundColor = UIColor.systemOrange
        
        let menuAction = UIContextualAction(style: .normal, title: "기타") { (action, view, complete) in
            print("MENU")
            complete(true)
        }
        menuAction.image = UIImage(systemName: "ellipsis")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, flagAction, menuAction])
        configuration.performsFirstActionWithFullSwipe = true//첫번째 끝까지 스와이프 시 실행
        return configuration
    }
}















