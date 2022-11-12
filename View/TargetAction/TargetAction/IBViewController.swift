import UIKit

class IBViewController: UIViewController {
    
    
    @IBAction func test1(_ sender: Any) {
        //sender -> 이벤트가 발생한 대상이 전달
    }
    //interfaceBuilder에서는 @IBAction이 추가됨
    //반대로 viewDidLoad에서는 추가하지 않아도됨
    @IBAction func test2() {
    }
    @IBAction func test3(_ sender: Any, forEvent event: UIEvent) {
    }
    @IBAction func sliderChanged(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

