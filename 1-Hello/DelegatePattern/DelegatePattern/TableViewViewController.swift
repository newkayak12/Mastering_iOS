import UIKit

class TableViewViewController: UIViewController {
   
    /**
     ...dataSource : 테이블 데이터를 제공해달라고 요청
     ...delegate : 동작을 위임함
      -> 메소드를 호출 (반드시 지정된 형식으로) *** 프로토콜을 준수해야함
     eventListener가 listen을 하면 SendingRequest(CallingMethod)
     
     1. 만약 위임할 객체가 없다면
     -> CRASH!!(꼭 처리해야하는 이벤트라면)
     2. 필수 메소드를 구현하지 않았다면
     -> CRASH!!
     3. 이벤트가 발생했는데 반드시 처리할 필요가 없는 이벤트라면
     -> 반응 없음
     
     
        > 1. checking the methods to implement(필수 / 선택적 메소드 확인)
        > 2. connecting two Objects (viewController가 delegate 객체가 된다 주로)
        > 3. implemening protocol methods (직접 구현하든 extension으로 하던)
     
     */
    let list = ["Apple", "Google", "Microsoft"]
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count; //테이블 view가 몇 개를 호출해야할 지 모를 때 호출
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        //테이블뷰가 어떤 디자인을 어떻게 보여야할지 모를 떄 호출
//        cell.textLabel?.text = list[indexPath.row]
//        return cell;
//
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(list[indexPath.row])
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}





extension TableViewViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count; //테이블 view가 몇 개를 호출해야할 지 모를 때 호출
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //테이블뷰가 어떤 디자인을 어떻게 보여야할지 모를 떄 호출
        cell.textLabel?.text = list[indexPath.row]
        return cell;
        
    }
}




extension TableViewViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(list[indexPath.row])
    }
}













