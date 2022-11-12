import UIKit

class CodeViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    //코드로 연결하면 @IBAction 추가 안함
    //대신 @Objc를 사용
    @objc func action() {
        
    }
    @objc func action(_ sender: Any){
        print(#function)
    }
    @objc func action(_ sender: Any, forEvent event: UIEvent){
        
    }
    @objc func slider(_ sender: Any){
        print(#function)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let sel = #selector(action(_:))
        btn.addTarget(self, action: sel, for: .touchUpInside)
        slider.addTarget(self, action: #selector(slider(_:)), for: .valueChanged)
        
    }
}
