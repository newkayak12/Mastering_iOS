import UIKit

class StackViewArrangedSubviewsViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func add(_ sender: Any) {
        let v = generateView()
        stackView.addArrangedSubview(v)
        //파라미터로 전달된 view를 array 맨 뒤에 push
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    @IBAction func insert(_ sender: Any) {
        let v = generateView()
        stackView.insertArrangedSubview(v, at: 0)
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
    }
    
    @IBAction func remove(_ sender: Any) {
        guard stackView.arrangedSubviews.count > 0 else {
            return
        }
        
        let index = Int.random(in: 0 ..< stackView.arrangedSubviews.count)
        let v = stackView.arrangedSubviews[index]
        
        UIView.animate(withDuration: 0.3) {
            v.isHidden = true
        } completion: { finished in
            self.stackView.removeArrangedSubview(v)
        }
//        v.removeFromSuperview()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let v = generateView()
        v.frame = stackView.bounds
        stackView.addSubview(v)
        //arrangedSubview는 stackview가 관리
        //subview는 그렇지 않음
        
    }
}

extension StackViewArrangedSubviewsViewController {
    private func generateView() -> UIView {
        let v = UIView()
        
        let r = CGFloat.random(in: 0.0 ... 256.0) / 255
        let g = CGFloat.random(in: 0.0 ... 256.0) / 255
        let b = CGFloat.random(in: 0.0 ... 256.0) / 255
        v.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        
        return v
    }
}
