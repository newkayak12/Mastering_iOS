//
//  ViewController.swift
//  HelloWorld
//
//  Created by Sang Hyeon kim on 2022/11/05.
//

import UIKit

class ViewController: UIViewController {

    //속성을 읽거나 바꾸고 싶다면 Outlet을 연결한다.
    
    @IBOutlet weak var label: UILabel!
    @IBAction func updateBtn(_ sender: Any) {
        label.text = "Hello, iOS"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

