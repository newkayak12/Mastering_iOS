import UIKit

class DispatchSourceTimerViewController: UIViewController {
   
   @IBOutlet weak var timeLabel: UILabel!
   
   lazy var formatter: DateFormatter = {
      let f = DateFormatter()
      f.dateFormat = "hh:mm:ss"
      return f
   }()
   
    var timer: DispatchSourceTimer?
   @IBAction func start(_ sender: Any) {
       if timer == nil {
           timer = DispatchSource.makeTimerSource(flags:[], queue: DispatchQueue.main)
           timer?.schedule(deadline: .now(), repeating: 1)
           timer?.setEventHandler(handler: {
               self.timeLabel.text = self.formatter.string(from: Date())
               print(self.timeLabel.text ?? "")
           })
       }
       
       timer?.resume()
   }
   
   @IBAction func suspend(_ sender: Any) {
       timer?.suspend()
   }
   
   @IBAction func stop(_ sender: Any) {
       timer?.cancel()
       timer = nil
   }
   
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
       timer?.resume()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
       stop(self)
   }
}
