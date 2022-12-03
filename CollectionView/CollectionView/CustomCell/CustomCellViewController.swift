import UIKit

class CustomCellViewController: UIViewController {
    
    let list = MaterialColorDataSource.generateSingleSectionData()
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UICollectionViewCell else {return}
        guard let indexPath = listCollectionView.indexPath(for: cell) else {return}
        
        let target = list[indexPath.item]
        segue.destination.view.backgroundColor = target.color
        segue.destination.title = target.title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        listCollectionView.visibleCells
//        listCollectionView.cellForItem(at: <#T##IndexPath#>) //return cell optional
//        listCollectionView.indexPath(for: <#T##UICollectionViewCell#>)// return indexPath
//        listCollectionView.indexPathsForVisibleItems // 좌표
//        listCollectionView.indexPathsForSelectedItems //선택된
        
        
        
    }
}




extension CustomCellViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorCollectionViewCell
        let target = list[indexPath.item]
        cell.colorView.backgroundColor = target.color
        cell.hexLabel.text = target.hex
        cell.nameLabel.text = target.title
        
        return cell
    }
}















