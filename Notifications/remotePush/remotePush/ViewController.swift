//
//  ViewController.swift
//  remotePush
//
//  Created by Sang Hyeon kim on 2022/12/16.
//

import UIKit

extension NSNotification.Name {
    static let DataDidReceive = NSNotification.Name(rawValue: "DataDidRaceiveNotification")
}



class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    @objc func updateLabel(){
        DispatchQueue.main.async {
            self.label.text = UserDefaults.standard.string(forKey: "data")
        }
    }

    override func viewDidLoad() {
        updateLabel()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: NSNotification.Name.DataDidReceive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: UIApplication.willEnterForegroundNotification, object: nil)
    }


}

