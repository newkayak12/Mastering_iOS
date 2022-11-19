import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img1 = UIImage(named: "iphone")
//        let img2 = Image //
        imageView.image = img1
        
        if let ptSize = img1?.size {
            print("Image Size: \(ptSize)")
        }
        if let ptSzie = img1?.size, let scale = img1?.scale {
            let px = CGSize(width: ptSzie.width * scale, height: ptSzie.height * scale)
            print("Image Size(px): \(px)")
        }
        img1?.cgImage
        img1?.ciImage
        
        let pngData = img1?.pngData()
        let jpgData = img1?.jpegData(compressionQuality: 1.0)
    }
}













