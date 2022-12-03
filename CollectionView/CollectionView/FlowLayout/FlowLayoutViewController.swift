import UIKit

class FlowLayoutViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    let list = MaterialColorDataSource.generateMultiSectionData()
    
    
    @objc func toggleScrollDirection() {
        guard let layout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return }
        listCollectionView.performBatchUpdates {
            layout.scrollDirection = layout.scrollDirection == .vertical ? .horizontal : .vertical
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(toggleScrollDirection))
        
        if let layout =  listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
}




extension FlowLayoutViewController: UICollectionViewDataSource {
    
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

extension FlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("#1",#function)
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {return .zero}
        
// 이렇게 delegate값을 먼저 가져와서 사용하거나
//        let itemSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: indexPath.section)
        
        var bounds = collectionView.bounds
        bounds.size.height += bounds.origin.y
        
        var width = bounds.width - (layout.sectionInset.left + layout.sectionInset.right)
        var height = bounds.height - (layout.sectionInset.top + layout.sectionInset.bottom)
        
        switch layout.scrollDirection {
            case .vertical:
                height = (height - ( layout.minimumLineSpacing * 4)) / 5
                
                if indexPath.item > 0 {
                    width = (width - (layout.minimumLineSpacing * 2)) / 3
                }
            case .horizontal:
                width = (width - (layout.minimumLineSpacing * 2)) / 3
                if indexPath.item > 0 {
                    height = (height - (layout.minimumInteritemSpacing * 4)) / 5
                }
            default:
                break;
        }
        
        return CGSize(width: width.rounded(.down), height: height.rounded(.down))
    }
//이렇게 delegate로 구현 가능
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        print("#2",#function)
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        print("#3",#function)
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        print("#4",#function)
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}















