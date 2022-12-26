import UIKit

class TimerViewController: UIViewController {
   
   @IBOutlet weak var timeLabel: UILabel!
   
   lazy var formatter: DateFormatter = {
      let f = DateFormatter()
      f.dateFormat = "hh:mm:ss"
      return f
   }()
   
   @IBAction func unwindToTimerHome(_ sender: UIStoryboardSegue) {
      
   }
   
   func updateTimer(_ timer: Timer) {
      print(#function, Date(), timer)
      timeLabel.text = formatter.string(from: Date())
   }
   
   func resetTimer() {
      timeLabel.text = "00:00:00"
   }
   
    
    
   var timer: Timer?
    @objc func timerFired(_ timer: Timer){
        updateTimer(timer)
    }
    
   @IBAction func startTimer(_ sender: Any) {
       guard timer == nil else {return}
       
//       timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
//           guard timer.isValid else {return}
//           self.updateTimer(timer)
//       })
       
       timer = Timer(timeInterval: 1, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
       //이러면 타이머 생성했지만 실행하지 않음
       
       timer?.tolerance = 0.2
       
       RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
       timer?.fire()
       print(#function)
   }
    
   
   @IBAction func stopTimer(_ sender: Any) {
       timer?.invalidate()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      resetTimer()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      startTimer(self)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
       timer?.invalidate()
       timer = nil
   }
}
