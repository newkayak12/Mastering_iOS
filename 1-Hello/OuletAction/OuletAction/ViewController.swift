//
//  ViewController.swift
//  OuletAction
//
//  Created by Sang Hyeon kim on 2022/11/06.
//

import UIKit

class ViewController: UIViewController {
//scean은 UIViewController를 상속받은 곳과 연결해야한다.
    
//    @IBOutlet weak var lbl: UILabel!
    /*
    일반 속성과 다르다. 항상 @IBOultet이 추가된다.
    이는 아울렛 속성을 가졌다는 것을 알려준다.
    🔘의 경우는 연결되어 있을 때 표시된다. 끊어져 있을 때
     아울렛에 접근하면 crash가 난다.
    */
    
//    @IBAction func btn(_ sender: Any) {
//        /**
//         @IBAction도 @IBOutlet과 유사한 역할을 한다.
//         */
//        lbl.text = "Hi"
//    }
    
    
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var btn: UIButton! //IUO(Implicitly Unwrapped Optionals)로 선언되어 있음
    
    @IBAction func test(_ sender: Any) { //여기에 접근하는건 문제가 없음
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        btn.backgroundColor = .systemBlue
        test(self)
    }


}

