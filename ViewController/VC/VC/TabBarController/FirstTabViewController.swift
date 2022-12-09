
import UIKit

class FirstTabViewController: UIViewController {
    
    @IBAction func selectSecondTab(_ sender: Any) {
     //선택할 child를 지정
        guard let secondChild = tabBarController?.viewControllers?[1] else {return}
        tabBarController?.selectedViewController = secondChild
    }
    
    
    @IBAction func selectThirdTab(_ sender: Any) {
     //선택할 탭을 인덱스로 지정
        tabBarController?.selectedIndex = 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem.title = "First"
        tabBarItem.badgeValue = "HOT"
        tabBarItem.badgeColor = .blue
        
        let standard = UITabBarAppearance()
        standard.backgroundColor = view.backgroundColor
        let stacked = UITabBarItemAppearance()
        stacked.selected.iconColor = .white
        stacked.selected.titleTextAttributes = [.foregroundColor:UIColor.white]
        stacked.normal.iconColor = .white.withAlphaComponent(0.5)
        stacked.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        
        standard.stackedLayoutAppearance = stacked
        standard.inlineLayoutAppearance = stacked
        standard.compactInlineLayoutAppearance = stacked
        
        
        tabBarItem.standardAppearance = standard
        if #available(iOS 15.0, *) {
            tabBarItem.scrollEdgeAppearance = standard
        }
        
    }
}


