
import UIKit

class TableViewBasicsViewController: UIViewController {
    
    let list = ["iPhone", "iPad", "Apple Watch", "iMac Pro", "iMac 5K", "Macbook Pro", "Apple TV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension TableViewBasicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("#1", #function)
//        return list.count //section에서 표시할 cell 개수
        //tableView 초기화, reload시
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("#2", #function, indexPath)
        //cell 생성시 tableView에 요청해야함
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)//재사용 queue 확인 -> 재사용할 것은 사용하고 새로 만들 것은 만듦
//        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell;
    }
    
    
}




/**
 
 TABLE VIEW 구현 순서
 
1. storyboard에서 tableview 추가
2. 새로운 prototypeCell추가
3. prototypeCell에 cellIdentifier 설정
4. tableview의 datasource 추가 delegate도 함께 지정
5. datasource로 지목된 클래스에서 UITableViewDataSource의 필수 메소드 구현
 */
























