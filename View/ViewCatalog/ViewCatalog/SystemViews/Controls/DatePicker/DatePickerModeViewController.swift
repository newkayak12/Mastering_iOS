import UIKit

class DatePickerModeViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        print(sender.date)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ko_kr")
        picker.minuteInterval = 1
        
        picker.setDate(Date(), animated: true)
        var compo = DateComponents()
        let cal = Calendar.current
        compo.day = -100
        
        picker.minimumDate = cal.date(byAdding: compo, to: Date())
        compo.day = +100
        picker.maximumDate = cal.date(byAdding: compo
                                      , to: Date())
        
        //캘린더, 타임존 코드로
        picker.calendar = Calendar.current
        picker.timeZone = TimeZone.current
    }
}
