import UIKit

class ImageFilterViewController: UIViewController {
   
   @IBOutlet weak var listCollectionView: UICollectionView!
   
    
    let downloadQueue = DispatchQueue(label: "DownloadQueue", attributes: .concurrent)
    let downloadGroup = DispatchGroup()
    
    let filterQueue = DispatchQueue(label: "FilterQueue", attributes: .concurrent)
    
    
   var isCancelled = false
   
   @IBAction func start(_ sender: Any) {
      PhotoDataSource.shared.reset()
      listCollectionView.reloadData()
      
      isCancelled = false
     
       PhotoDataSource.shared.list.forEach { data in
           self.downloadQueue.async(group: downloadGroup) {
               self.downloadAndResize(target: data)
           }
       }
       
       self.downloadGroup.notify(queue: DispatchQueue.main) {
           self.reloadCollectionView()
       }
       
       self.downloadGroup.notify(queue: self.filterQueue){
           DispatchQueue.concurrentPerform(iterations: PhotoDataSource.shared.list.count) { index in
               let data = PhotoDataSource.shared.list[index]
               self.applyFilter(target: data)
               let targetIndexPath = IndexPath(item: index, section: 0)
               
               DispatchQueue.main.async {
                   self.reloadCollectionView(at: targetIndexPath)
               }
           }
       }
      
   }
   
   @IBAction func cancel(_ sender: Any) {
      isCancelled = true
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      PhotoDataSource.shared.reset()
   }   
}


extension ImageFilterViewController {
   func reloadCollectionView(at indexPath: IndexPath? = nil) {
      guard !isCancelled else { print("RELOAD: Cancelled"); return }
      
      print("RELOAD: Start", indexPath ?? "")
      
      defer {
         if isCancelled {
            print("RELOAD: Cancelled", indexPath ?? "")
         } else {
            print("RELOAD: Done", indexPath ?? "")
         }
      }
      
      if let indexPath = indexPath {
         if listCollectionView.indexPathsForVisibleItems.contains(indexPath) {
            listCollectionView.reloadItems(at: [indexPath])
         }
      } else {
         listCollectionView.reloadData()
      }
   }
   
   func downloadAndResize(target: PhotoData) {
      print("DOWNLOAD & RESIZE: Start")
      
      defer {
         if isCancelled {
            print("DOWNLOAD & RESIZE: Cancelled")
         } else {
            print("DOWNLOAD & RESIZE: Done")
         }
      }
      
      guard !Thread.isMainThread else { fatalError() }
      
      guard !isCancelled else { print("DOWNLOAD & RESIZE: Cancelled"); return }
      
      do {
         let data = try Data(contentsOf: target.url)
         
         guard !isCancelled else { print("DOWNLOAD & RESIZE: Cancelled"); return }
         
         if let image = UIImage(data: data) {
            let size = image.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
            UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
            let frame = CGRect(origin: CGPoint.zero, size: size)
            image.draw(in: frame)
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            guard !isCancelled else { print("DOWNLOAD & RESIZE: Cancelled"); return }
            
            target.data = resultImage
         }
      } catch {
         print(error.localizedDescription)
      }
   }
   
   func applyFilter(target: PhotoData) {
      print("FILTER: Start")

      defer {
         if isCancelled {
            print("FILTER: Cancelled")
         } else {
            print("FILTER: Done")
         }
      }

      guard !Thread.isMainThread else { fatalError() }
      guard !isCancelled else { print("FILTER: Cancelled"); return }
      
      guard let source = target.data?.cgImage else { fatalError() }
      let ciImage = CIImage(cgImage: source)
      
      guard !isCancelled else { print("FILTER: Cancelled"); return }
      
      let filter = CIFilter(name: "CIPhotoEffectNoir")
      filter?.setValue(ciImage, forKey: kCIInputImageKey)
      
      guard !isCancelled else { print("FILTER: Cancelled"); return }
      
      guard let ciResult = filter?.value(forKey: kCIOutputImageKey) as? CIImage else { fatalError() }
      
      guard !isCancelled else { print("FILTER: Cancelled"); return }
      
      guard let cgImg = PhotoDataSource.shared.filterContext.createCGImage(ciResult, from: ciResult.extent) else {
         fatalError()
      }
      target.data = UIImage(cgImage: cgImg)
      
      Thread.sleep(forTimeInterval: TimeInterval(arc4random_uniform(3)))
   }
}

extension ImageFilterViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return PhotoDataSource.shared.list.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      
      let target = PhotoDataSource.shared.list[indexPath.item]
      if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
         imageView.image = target.data
      }
      
      return cell
   }
}


extension ImageFilterViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let w = collectionView.bounds.width / 3
      return CGSize(width: w, height: w * (768 / 1024))
   }
}
