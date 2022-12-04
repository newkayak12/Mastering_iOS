import UIKit
/**
    init ->
                viewDidLoad (딱 한 번만 호출 -> outlet, action 모두 연결됨)
                                                                                *******반복되어 호출될 수도 있음
                viewWillAppear (rootview가 view에 추가되기 직전)
                viewDidAppear  (view에 rootView 추가)
                viewWillDisappear (rootView 사라지기 전)
                viewDidDisappear (rootView 사라지고 다른 rootView가 보일 수도
 
                                                                            -> deinit
 */
class LifeCycleViewController: UIViewController {
    
    @IBAction func showAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Lorem Ipsum", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(className, #function)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(className, #function)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(className, #function)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(className, #function)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print(className, #function)
    }
    
    
    deinit {
        print(className, #function)
    }
}



extension UIViewController {
    var className: String {
        return String(describing: type(of: self))
    }
}








