// UIResponder.keyboardDidHideNotification
// UIResponder.keyboardDidShowNotification
// UIResponder.keyboardWillHideNotification
// UIResponder.keyboardWillShowNotification
// UIResponder.keyboardWillChangeFrameNotification
// UIResponder.keyboardDidChangeFrameNotification

import UIKit

class KeyboardNotificationViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { noti in
            //이러면 고정 폭이라 문제가 되고 스크롤 바도 부자연스러움
//            var inset = self.textView.contentInset
//            inset.bottom = 350
//            self.textView.contentInset = inset
            
            guard let userInfo = noti.userInfo else { return }
            
            guard let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            var inset = self.textView.contentInset
            inset.bottom = frame.height
            self.textView.contentInset = inset
            self.textView.scrollIndicatorInsets = inset
            
            
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { noti in
            var inset = self.textView.contentInset
            inset.bottom = 8
            self.textView.contentInset = inset
        }
    }
}
