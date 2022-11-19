import UIKit

class ImageAnimationViewController: UIViewController {
    
    let images = [
        UIImage(systemName: "speaker")!,
        UIImage(systemName: "speaker.1")!,
        UIImage(systemName: "speaker.2")!,
        UIImage(systemName: "speaker.3")!
    ]
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func startAnimation(_ sender: Any) {
        imageView.startAnimating()
        //반복 횟수, 프레임 지정하지 않으면 무제한 /초당 30프레임으로 반복
    }
    
    @IBAction func stopAnimation(_ sender: Any) {
        if imageView.isAnimating {
            imageView.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        imageView.animationRepeatCount = 3
        
    }
}
