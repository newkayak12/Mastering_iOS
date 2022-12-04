//
//  MyViewController.swift
//  VC
//
//  Created by Sang Hyeon kim on 2022/12/04.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func fromCode(_ sender: Any) {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemYellow
        navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
