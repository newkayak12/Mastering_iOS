
import UIKit

class FilterOperation: Operation {
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
         
         guard let source = target.data?.cgImage else { fatalError() }
         let ciImage = CIImage(cgImage: source)
         
         guard !isCancelled else { print(self, "Cancelled"); return }
         
         let filter = CIFilter(name: "CIPhotoEffectNoir")
         filter?.setValue(ciImage, forKey: kCIInputImageKey)
         
         guard !isCancelled else { print(self, "Cancelled"); return }
         
         guard let ciResult = filter?.value(forKey: kCIOutputImageKey) as? CIImage else { fatalError() }
         
         guard !isCancelled else { print(self, "Cancelled"); return }
         
         Thread.sleep(forTimeInterval: TimeInterval(arc4random_uniform(3)))
         
         guard !isCancelled else { print(self, "Cancelled"); return }
         guard let cgImg = PhotoDataSource.shared.filterContext.createCGImage(ciResult, from: ciResult.extent) else {
            fatalError()
         }
         target.data = UIImage(cgImage: cgImg)
      }
   }
   
   override func cancel() {
      super.cancel()
      
      print(self, "Cancel")
   }
}














