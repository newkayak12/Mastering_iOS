import UIKit

class SelectionViewController: UIViewController {
    
    lazy var list: [MaterialColorDataSource.Color] = {
        (0...2).map { _ in
            MaterialColorDataSource.generateSingleSectionData()
        }.reduce([], +)
    }()
    
    
    lazy var checkImage: UIImage? = UIImage(systemName: "checkmark.circle")
    
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    func selectRandomItem() {
        let item = Int.random(in: 0 ..< list.count)
        let targetIndexPath = IndexPath(item: item, section: 0)
        listCollectionView.selectItem(at: targetIndexPath, animated: true, scrollPosition: .centeredHorizontally)
        let color = list[item].color
        view.backgroundColor = color
    }
    
    
    func reset() {
//        listCollectionView.deselectItem(at: <#T##IndexPath#>, animated: <#T##Bool#>)
//          하나만 선택 해제한다면
        
        listCollectionView.selectItem(at: nil, animated: true, scrollPosition: .left)
//          모든 것을 선택 해제
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        listCollectionView.scrollToItem(at: firstIndexPath, at: .left, animated: true)
        view.backgroundColor = .white
        //code로 선택하면 delegate가 동작하지 않음 -> 터치 이벤트가 아니니까!
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
        listCollectionView.allowsSelection = true
        listCollectionView.allowsMultipleSelection = false
    }
}



extension SelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = list[indexPath.row].color
        
        return cell
    }
}

extension SelectionViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("#2", indexPath,#function)
        guard let list = collectionView.indexPathsForSelectedItems else {
            return true
        }
        return !list.contains(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("#1", indexPath, #function)
        let color = list[indexPath.item].color
        view.backgroundColor = color
        
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
//                imageView.image = checkImage
//            }
//        } //ImageView가 아닌 Highlight로
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        print("#3", indexPath, #function)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
//                imageView.image = nil
//            }
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        print("#3", indexPath, #function)
//        return false //highlight를 못하면 선택도 안된다.
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        print("#4", indexPath, #function)
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 6
        }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        print("#5", indexPath, #function)
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.layer.borderWidth = 0
        }
    }
    
}


extension SelectionViewController {
    @objc func showMenu() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let randomAction = UIAlertAction(title: "Select Random Item", style: .default) { [weak self] (action) in
            self?.selectRandomItem()
        }
        actionSheet.addAction(randomAction)
        
        let resetPositionAction = UIAlertAction(title: "Reset", style: .default) { [weak self] (action) in
            self?.reset()
        }
        actionSheet.addAction(resetPositionAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
}










