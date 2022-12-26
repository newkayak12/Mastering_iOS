
import UIKit

class DownloadOperation: Operation {
   let target: PhotoData
   
   init(target: PhotoData) {
      self.target = target
      
      super.init()
   }
   
   override func main() {
      autoreleasepool {
         print(self, "Start")
         
         defer {
            if isCancelled {
               print(self, "Cancelled")
            } else {
               print(self, "Done")
            }
         }
         
         guard !Thread.isMainThread else { fatalError() }
         
         guard !isCancelled else { print(self, "Cancelled"); return }
         
         do {
            let data = try Data(contentsOf: target.url)
            
            guard !isCancelled else { print(self, "Cancelled"); return }
            
            if let image = UIImage(data: data) {
               let size = image.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
               UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
               let frame = CGRect(origin: CGPoint.zero, size: size)
               image.draw(in: frame)
               let resultImage = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
               
               guard !isCancelled else { print(self, "Cancelled"); return }
               
               target.data = resultImage
            }
         } catch {
            print(error.localizedDescription)
         }
         
         Thread.sleep(forTimeInterval: TimeInterval(arc4random_uniform(4)))
      }
   }
   
   override func cancel() {
      super.cancel()
      
      print(self, "Cancel")
   }
}























