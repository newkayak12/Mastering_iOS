//
//  CustomTabBarController.swift
//  VC
//
//  Created by Sang Hyeon kim on 2022/12/09.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//
/**
 원형
 regular tab bar = 25pt
 compact tab bar = 18pt
 
 사각형
 regular tab bar = 23pt
 compact tab bar = 17pt
 */

import UIKit

class CustomTabBarController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
//
//        if let dict = UserDefaults.standard.object(forKey: "tabOrder") as? [String:Int],
//           let list = viewControllers {
//            var newList = [UIViewController]()
//
//            for index in dict.keys.sorted(){
//                let child = list.first { $0.tabBarItem.tag == dict[index]}
//                newList.append(child!)
//            }
//
//            viewControllers = newList
//        }
//
//        customizableViewControllers = Array(customizableViewControllers!.dropFirst(2))
    }
    

}
extension CustomTabBarController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if let secondVC = tabBarController.viewControllers?[1]{
//            return viewController != secondVC
//        }
        
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //탭을 선택하고 이벤트를 처리하고 싶다면 여기! item을 이용해서
    }
    
    override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
        //커스터마이징 직전
    }
    override func tabBar(_ tabBar: UITabBar, willEndCustomizing items: [UITabBarItem], changed: Bool) {
        //커스터마이징 반영 직전
    }
    override func tabBar(_ tabBar: UITabBar, didBeginCustomizing items: [UITabBarItem]) {
        //커스터마이징 끝
    }
    func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        var dict = [String:Int]()
        
        for (index, vc) in viewControllers.enumerated() {
            dict["\(index)"] = vc.tabBarItem.tag
        }
        
        UserDefaults.standard.set(dict, forKey: "tabOrder")
    }
}
