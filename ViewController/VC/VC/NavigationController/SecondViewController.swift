import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func pop(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func pushThird(_ sender: Any) {
        guard let thirdVC = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") else {return}
//        navigationController?.pushViewController(thirdVC, animated: false)
        
        guard let fourthVC = storyboard?.instantiateViewController(withIdentifier: "FourthViewController") else {return}
//        navigationController?.pushViewController(fourthVC, animated: false)
        
        //2 -> 5 -> 4
        guard let fifthVC = storyboard?.instantiateViewController(withIdentifier: "FifthViewController") else {return}
        navigationController?.pushViewController(fifthVC, animated: true)
        
        if var navigationStack = navigationController?.viewControllers, let index = navigationStack.firstIndex(of: fifthVC){
            navigationStack.insert(fourthVC, at: index)
            navigationStack.insert(thirdVC, at: index)
            navigationController?.viewControllers = navigationStack
            //네비게이션 스택 직접 조작
        }
    }
    
    
    @objc func addRightButtons() {
        let btn1 = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        let btn2 = UIBarButtonItem(title: "Two", style: .plain, target: nil, action: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}


























