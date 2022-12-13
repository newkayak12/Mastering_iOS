import UIKit

class CustomTransitionViewController: UIViewController {
   
   var list = (1 ... 10).map { return UIImage(named: "\($0)")! }
   
   @IBOutlet weak var listCollectionView: UICollectionView!
   
    let animator = ZoomAnimationController()
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? ImageViewController {
         if let cell = sender as? UICollectionViewCell, let indexPath = listCollectionView.indexPath(for: cell) {
            vc.image = list[indexPath.item]
            
             
             animator.targetImage = list[indexPath.item]
             animator.targetIndexPath = indexPath
             
         }
      }
       
       segue.destination.transitioningDelegate = self
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}

extension CustomTransitionViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting =  true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
}



extension CustomTransitionViewController: UICollectionViewDataSource {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return list.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      
      if let imgView = cell.contentView.viewWithTag(100) as? UIImageView {
         imgView.image = list[indexPath.item]
      }
      
      return cell
   }
}


extension CustomTransitionViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: (collectionView.bounds.width / 2), height: (collectionView.bounds.width / 2) * (768.0 / 1024.0))
   }
}













