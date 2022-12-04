 import UIKit

class ViewManagementViewController: UIViewController {
    
    var grayView: UIView?
    
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var greenView: UIView!
    
    @IBOutlet weak var blueView: UIView!
    
    
    func addRandomView() {
        let v = generateRandomView()
        view.addSubview(v)
        //View는 subView를 배열로 관리
    }
    
    
    func insertRandomViewToBack() {
        let v = generateRandomView()
        view.insertSubview(v, at: 0)//가장 앞
        
    }
    
    
    func removeTopmostRandomView() {
        let topmostRandomView = view.subviews.reversed().first{ $0.tag > 0}
        topmostRandomView?.removeFromSuperview()
    }
    
    
    func bringRedViewToFront() {
        view.bringSubview(toFront: redView)
    }
    
    
    func sendRedViewToBack() {
        view.sendSubview(toBack: redView)
    }
    
    
    func switchGreenViewWithBlueView() {
        print(#function)
        guard let greenViewIndex = view.subviews.firstIndex(of: greenView) else {return}
        guard let blueViewIndex = view.subviews.firstIndex(of: blueView) else {return}
        view.exchangeSubview(at: greenViewIndex, withSubviewAt: blueViewIndex)
    }
    
    
    func addGrayViewToRedView() {
        grayView = generateGrayView()
        redView.addSubview(grayView!)
    }
    
    
    func moveGrayViewToRootView() {
        if let grayView = grayView {
            view.addSubview(grayView)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
    }
}



extension ViewManagementViewController {
    @objc func showMenu() {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let addRandomViewAction = UIAlertAction(title: "Add Random View", style: .default) { [weak self] (action) in
            self?.addRandomView()
        }
        menu.addAction(addRandomViewAction)
        
        let insertRandomViewToBackAction = UIAlertAction(title: "Insert Random View to Back", style: .default) { [weak self] (action) in
            self?.insertRandomViewToBack()
        }
        menu.addAction(insertRandomViewToBackAction)
        
        let removeTopmostRandomViewAction = UIAlertAction(title: "Remove Topmost Random View", style: .default) { [weak self] (action) in
            self?.removeTopmostRandomView()
        }
        menu.addAction(removeTopmostRandomViewAction)
        
        let bringRedViewToFrontAction = UIAlertAction(title: "Bring Red View to Front", style: .default) { [weak self] (action) in
            self?.bringRedViewToFront()
        }
        menu.addAction(bringRedViewToFrontAction)
        
        let sendRedViewToBackAction = UIAlertAction(title: "Send Red View to Back", style: .default) { [weak self] (action) in
            self?.sendRedViewToBack()
        }
        menu.addAction(sendRedViewToBackAction)
        
        let switchGreenViewWithBlueViewAction = UIAlertAction(title: "Switch Green View with Blue View", style: .default) { [weak self] (action) in
            self?.switchGreenViewWithBlueView()
        }
        menu.addAction(switchGreenViewWithBlueViewAction)
        
        let addGrayViewToRedViewAction = UIAlertAction(title: "Add Gray View to Red View", style: .default) { [weak self] (action) in
            self?.addGrayViewToRedView()
        }
        menu.addAction(addGrayViewToRedViewAction)
        
        let moveGrayViewToRootViewAction = UIAlertAction(title: "Move Gray View to Root View", style: .default) { [weak self] (action) in
            self?.moveGrayViewToRootView()
        }
        menu.addAction(moveGrayViewToRootViewAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        menu.addAction(cancelAction)
        
        present(menu, animated: true, completion: nil)
    }
    
    func generateRandomView() -> UIView {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let v = UIView(frame: frame)
        v.center = view.center
        v.backgroundColor = UIColor.random
        v.tag = Int.random(in: 0..<Int(Int16.max)) + 1
        
        return v
    }
    
    func generateGrayView() -> UIView {
        let frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        let v = UIView(frame: frame)
        v.backgroundColor = UIColor.systemGray
        
        return v
    }
}



extension UIColor {
    static var random: UIColor {
        let r = CGFloat.random(in: 0 ..< 256) / 255
        let g = CGFloat.random(in: 0 ..< 256) / 255
        let b = CGFloat.random(in: 0 ..< 256) / 255
        
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
    }
}


















