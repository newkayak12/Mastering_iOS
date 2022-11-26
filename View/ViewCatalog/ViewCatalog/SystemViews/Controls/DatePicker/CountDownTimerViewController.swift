
import UIKit
import AudioToolbox

class CountDownTimerViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBAction func start(_ sender: Any) {
        timeLabel.text = "\(Int(picker.countDownDuration))"
        remainSeconds = Int(picker.countDownDuration)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.remainSeconds -= 1
            self.timeLabel.text = "\(self.remainSeconds)"
            
            if(self.remainSeconds == 0){
                timer.invalidate()
                AudioServicesPlaySystemSound(1315)
            }
        }
    }
    
    var remainSeconds = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.countDownDuration = 60 //초 단위
        
        
    }
}
