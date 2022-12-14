import UIKit

class NotificationCenterViewController: UIViewController {
    var token: NSObjectProtocol?
    
   @IBOutlet weak var valueLabel: UILabel!
   
    @objc func process(notification: Notification) {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread")
        guard let value = notification.userInfo?["NewValue"] as? String else {return}
        DispatchQueue.main.async { //       UILabel.text must be used from main thread only
            self.valueLabel.text = value
        }
        print("#1", #function)
    }
   override func viewDidLoad() {
      super.viewDidLoad()
       //방법1
       //self가 해제되면 Observer도 해제
       NotificationCenter.default.addObserver(self, selector: #selector(process(notification:)), name: NSNotification.Name.NewValueDidInput, object: nil)
       //방법2
       //DispatchTable에 그대로 등록 (self를 등록하지 않음) --> 옵저버 해제가 중요
       token = NotificationCenter.default.addObserver(forName: NSNotification.Name.NewValueDidInput, object: nil, queue: OperationQueue.main) {[weak self]  (notification) in
           print(Thread.isMainThread ? "Main Thread" : "Background Thread")
           guard let value = notification.userInfo?["NewValue"] as? String else {return}
           self?.valueLabel.text = value
           print("#2 handling \(notification.name)")
       }
   }
   
   deinit {
       //iOS9이전에서도 Crash없이
       NotificationCenter.default.removeObserver(self)
       if let token = token {
           NotificationCenter.default.removeObserver(token)
       }
      print(#function)
   }
}
