import UIKit

class ImageAttachmentViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    /**
     textkit을 사용
     textContainer 안에 텍스트가 들어있음
     여기에 image를 넣을 수도 있음
     */
    let logo = UIImage(named: "logo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attachment = NSTextAttachment()
        attachment.image = logo
        
        let attrStr = NSAttributedString(attachment: attachment)
        textView.textStorage.insert(attrStr, at: 0)
        
    }
}
