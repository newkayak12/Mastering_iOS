import UIKit

class TagViewController: UIViewController {
    //tag 값으로 view에 접근 -> viewTagging (outlet 없이 접근 가능)
    @IBAction func changeColor(_ sender: Any) {
        if let v = view.viewWithTag(100){
            //tag 값은 unique가 되어야한다.
            // 동일한 태그 값이 있다면 먼저 검색한 곳에서 종료
            v.backgroundColor = .black
        }
    }
}
