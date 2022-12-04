import UIKit

class EditViewController: UIViewController {
    
    var selectedList = [UIColor]()
    var colorList = MaterialColorDataSource.generateMultiSectionData()
    
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    func emptySelectedList() {
        selectedList.removeAll()
//        listCollectionView.deleteItems(at: <#T##[IndexPath]#>)
        let targetSection = IndexSet(integer: 0)
        listCollectionView.reloadSections(targetSection)
    }
    
    
    func insertSection() {
        let sectionData = MaterialColorDataSource.Section()
        colorList.insert(sectionData, at: 0)
        
        let targetSection = IndexSet(integer: 1)
        listCollectionView.insertSections(targetSection)
    }
    
    
    func deleteSecondSection() {
        colorList.remove(at: 0)
        
        let targetSection = IndexSet(integer: 1)
        listCollectionView.deleteSections(targetSection)
    }
    
    
    func moveSecondSectionToThird() {
        let target = colorList.remove(at: 0)
        colorList.insert(target, at: 1)
        
        
        listCollectionView.moveSection(1, toSection: 2)
        
    }
    
    
    func performBatchUpdates() {
        let deleteIndexPaths = (1 ..< 3).compactMap { _ in
            Int.random(in: 0 ..< colorList[0].colors.count)
        }.sorted(by: >)
            .map { IndexPath(item: $0, section: 1)}
        
        let insertIndexPaths = (0 ..< 4).compactMap { _ in
            Int.random(in: 0 ..< colorList[0].colors.count)
        }.sorted(by: <).map { IndexPath(item: $0, section: 1)
        }
        /**
         삭제, 추가 순서 중요
         삭제 -> 추가
         셀 삭제 하는 경우 내림차순으로 해야 (뒤에서 부터 삭제)
         셀 추가 하는 경우 오름차순으로 해야 (앞에서 부터 추가)
         */
        deleteIndexPaths.forEach { colorList[0].colors.remove(at: $0.item) }
        insertIndexPaths.forEach { colorList[0].colors.insert(UIColor.random, at: $0.item) }
        
        
//        listCollectionView.deleteItems(at: deleteIndexPaths)
//        listCollectionView.insertItems(at: insertIndexPaths)
        //이렇게 편집 메소드 연달아 실행하면 perfomrBatch로
        
        listCollectionView.performBatchUpdates {
            listCollectionView.deleteItems(at: deleteIndexPaths)
            listCollectionView.insertItems(at: insertIndexPaths)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showMenu))
    }
}



extension EditViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            selectedList.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])
            ///항상 원본 데이터 업데이트하고 collectionData 업데이트
        } else {
            let deleted = colorList[indexPath.section - 1].colors.remove(at: indexPath.item)
            //collectionView.deleteItems(at: [indexPath])
            
            let targetIndexPath = IndexPath(item: selectedList.count, section: 0)
            selectedList.append(deleted)
            //collectionView.insertItems(at: [targetIndexPath])
            
            collectionView.moveItem(at: indexPath, to: targetIndexPath)
        }
    }
}



extension EditViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return colorList.count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return selectedList.count
        }
        
        return colorList[section - 1].colors.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
        case 0:
            cell.contentView.backgroundColor = selectedList[indexPath.row]
        default:
            cell.contentView.backgroundColor = colorList[indexPath.section - 1].colors[indexPath.item]
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! EditingHeaderCollectionReusableView
        
        if indexPath.section == 0 {
            header.titleLabel.text = "Selected Color List"
        } else {
            header.titleLabel.text = colorList[indexPath.section - 1].title
        }
        
        return header
    }
}



extension EditViewController {
    @objc func showMenu() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let emptyListAction = UIAlertAction(title: "Empty Selected List", style: .default) { [weak self] (action) in
            self?.emptySelectedList()
        }
        actionSheet.addAction(emptyListAction)
        
        let insertSectionAction = UIAlertAction(title: "Insert Section", style: .default) { [weak self] (action) in
            self?.insertSection()
        }
        actionSheet.addAction(insertSectionAction)
        
        let delectSecondSectionAction = UIAlertAction(title: "Delete Second Section", style: .default) { [weak self] (action) in
            self?.deleteSecondSection()
        }
        actionSheet.addAction(delectSecondSectionAction)
        
        let moveSectionAction = UIAlertAction(title: "Move Second Section to Third", style: .default) { [weak self] (action) in
            self?.moveSecondSectionToThird()
        }
        actionSheet.addAction(moveSectionAction)
        
        let batchUpdatesAction = UIAlertAction(title: "Perform Batch Update", style: .default) { [weak self] (action) in
            self?.performBatchUpdates()
        }
        actionSheet.addAction(batchUpdatesAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        if let pc = actionSheet.popoverPresentationController {
            pc.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
}



extension UIColor {
    static var random: UIColor {
        let r = CGFloat.random(in: 1..<256) / 255
        let g = CGFloat.random(in: 1..<256) / 255
        let b = CGFloat.random(in: 1..<256) / 255
        
        return UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
    }
}










