
import UIKit

class TableViewCellViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = ["iPhone", "iPad", "Apple Watch", "iMac Pro", "iMac 5K", "Macbook Pro", "Apple TV"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            if let indexPath = listTableView.indexPath(for: cell) {
                if let vc = segue.destination as? DetailViewController {
                    vc.value = list[indexPath.row]
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        listTableView.indexPathForRow(at: <#T##CGPoint#>)//특정 좌표에 cell이 있다면 indexPath 리턴 없다면 nil
//        listTableView.indexPathsForRows(in: <#T##CGRect#>) //특정 영역 안에 있다면 indexPath리턴
//        listTableView.visibleCells //보이는 셀 배열로 리턴
//        listTableView.indexPathsForVisibleRows // 화면에 표시된 셀의 인덱스 path 리턴
    }
}



extension TableViewCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        cell.imageView?.image = UIImage(systemName: "star")
        return cell
    }
}



extension TableViewCellViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            print(cell.textLabel?.text ?? "")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row.isMultiple(of: 2){
            cell.backgroundColor = UIColor.systemBackground
        } else {
            cell.backgroundColor = UIColor.secondarySystemBackground
        }
    }
}

















