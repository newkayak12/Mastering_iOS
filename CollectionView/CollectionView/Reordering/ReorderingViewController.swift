import UIKit

class ReorderingViewController: UIViewController {
    
    var list = MaterialColorDataSource.generateMultiSectionData()
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: listCollectionView)
        switch sender.state {
            case .began:
                if let indexPath = listCollectionView.indexPathForItem(at: location){
                    listCollectionView.beginInteractiveMovementForItem(at: indexPath)
                }
            case .changed:
                listCollectionView.updateInteractiveMovementTargetPosition(location)
            case .ended:
                listCollectionView.endInteractiveMovement()
            default:
                listCollectionView.cancelInteractiveMovement()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}



extension ReorderingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //listCollectionView.endInteractiveMovement()가 끝나면 이 메소드가 호출됨
        
        let target = list[sourceIndexPath.section].colors.remove(at: sourceIndexPath.item)
        list[destinationIndexPath.section].colors.insert(target, at: destinationIndexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true //셀 이동시키기 전에 호출
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[section].colors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = list[indexPath.section].colors[indexPath.row]
        
        return cell
    }
}





