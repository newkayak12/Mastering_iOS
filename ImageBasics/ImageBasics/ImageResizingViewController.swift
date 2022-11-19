import UIKit
import CoreGraphics

class ImageResizingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let targetImage = UIImage(named: "photo"){
            let size = CGSize(width: targetImage.size.width / 5, height: targetImage.size.height / 5 )
//            imageView.image = resizingWithImageContext(image: targetImage, to: size)
            
            imageView.image = resizingWithBitmapContext(image: targetImage, to: size)
        }
        
    }
}




extension ImageResizingViewController {
    func resizingWithImageContext(image: UIImage, to size: CGSize) -> UIImage? {
        //투명하면 false, 아니면 true
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let frame = CGRect(origin: .zero, size: size)
        image.draw(in: frame)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return resultImage
    }
}

//#iOS Image Resizing
//#Swift Image Resizing

extension ImageResizingViewController { //이미지 리사이징하면서 비트맵 속성도 같이 바꾼다면
    func resizingWithBitmapContext(image: UIImage, to size: CGSize) -> UIImage? {
        //CoreGraphics에 있기 때문에 import 해야한다.
        guard let cgImage = image.cgImage else {
            //코어 그래픽스의 CG이미지로 바꿔야한다.
            return nil
        }
        let bpc = cgImage.bitsPerComponent
        let bpr = cgImage.bytesPerRow
        let colorSpace = cgImage.colorSpace!
        let bitmapInfo = cgImage.bitmapInfo
        
        //data -> 이미지의 포인터 전달해야함 nil 전달하면 알아서 처리해줌
        guard let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: bpc, bytesPerRow: bpr, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
                
        context.interpolationQuality = .high
        let frame = CGRect(origin: .zero, size: size)
        context.draw(cgImage, in: frame);
        
        guard let resultImage = context.makeImage() else {
            return nil;
        }
        
        
        return UIImage(cgImage: resultImage)
    }
}













