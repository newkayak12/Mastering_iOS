
import UIKit

class PhotoData {
   var url: URL
   var data: UIImage?
   
   init(url: String) {
      self.url = URL(string: url)!
   }
}

class PhotoDataSource {
   static let shared = PhotoDataSource()
   var list = [PhotoData]()
   let filterContext = CIContext(options: nil)
   
   func reset() {
      autoreleasepool {
         list.removeAll(keepingCapacity: true)
         
         (1...20).forEach {
            let url = "https://kxcodingblob.blob.core.windows.net/mastering-ios/\($0).jpg"
            let data = PhotoData(url: url)
            list.append(data)
         }
      }
   }
}















