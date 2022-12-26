
import UIKit

class DependencyViewController: UIViewController {
   
   let backgroundQueue = OperationQueue()
   let mainQueue = OperationQueue.main
   
   var uiOperations = [Operation]()
   var backgroundOperations = [Operation]()
   
   @IBOutlet weak var listCollectionView: UICollectionView!
   
   @IBAction func startOperation(_ sender: Any) {
      PhotoDataSource.shared.reset()
      listCollectionView.reloadData()
      uiOperations.removeAll()
      backgroundOperations.removeAll()
       
       DispatchQueue.global().async {
           let reloadOp = ReloadOperation(collectionView: self.listCollectionView)
           self.uiOperations.append(reloadOp)
           
           for (index, data) in PhotoDataSource.shared.list.enumerated(){
               let downloadOp = DownloadOperation(target: data)
               reloadOp.addDependency(downloadOp)
               self.backgroundOperations.append(downloadOp)
               
               let filterOp = FilterOperation(target: data)
               filterOp.addDependency(reloadOp)
               self.backgroundOperations.append(filterOp)
               
               let reloadItemOp = ReloadOperation(collectionView: self.listCollectionView, indexPath: IndexPath(item: index, section: 0))
               reloadItemOp.addDependency(filterOp)
               self.uiOperations.append(reloadItemOp)
           }
           
           
           self.backgroundQueue.addOperations(self.backgroundOperations, waitUntilFinished: false)
           self.mainQueue.addOperations(self.uiOperations, waitUntilFinished: false)
       }
   }
   
   
   @IBAction func cancelOperation(_ sender: Any) {
//       mainQueue.cancelAllOperations()
       //mainqueue 는 cancelAllOperations 만으로 취소 X
       uiOperations.forEach { $0.cancel()}
       backgroundQueue.cancelAllOperations()
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      PhotoDataSource.shared.reset()
       
       backgroundQueue.maxConcurrentOperationCount = 10 //1로 바꾸면 serial, 5보다 작으면 CPU 부하를 줄이는데 효과적
   }
}


extension DependencyViewController: UICollectionViewDataSource {
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


extension DependencyViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let w = collectionView.bounds.width / 3
      return CGSize(width: w, height: w * (768 / 1024))
   }
}
