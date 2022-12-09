import UIKit

class WhiteViewController: UIViewController {
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        if presentationController?.presentationStyle == .fullScreen {
//            return .darkContent
//        }
//        return .lightContent
//    }
    
    var hidden = false
    override var prefersStatusBarHidden: Bool{
        return hidden
    }
    
    @IBAction func toggleVisibility(_ sender: Any) {
        hidden.toggle()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    var style = UIStatusBarStyle.default
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return style
    }
    @IBAction func toggleStyle(_ sender: Any) {
        style = style == .default ? .lightContent : style == .lightContent ? .darkContent : .default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationCapturesStatusBarAppearance = true
        //기본 값이 false
        
    }
}
























