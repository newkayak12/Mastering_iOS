import UIKit

class SupplementaryViewViewController: UIViewController {
    
    let list = MaterialColorDataSource.generateMultiSectionData()
    
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.sectionHeadersPinToVisibleBounds = true
//            layout.sectionFootersPinToVisibleBounds = true
            layout.footerReferenceSize = CGSize(width: 50, height: 50)
        }
        
        listCollectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        
//        listCollectionView.supplementaryView(forElementKind: <#T##String#>, at: <#T##IndexPath#>)
        //지정된 위치의 supplementaryView에 접근
        
//        listCollectionView.indexPathsForVisibleSupplementaryElements(ofKind: <#T##String#>)
//          보이는 view의 kind가 일치하는 녀석의 indexPath
        
//        listCollectionView.visibleSupplementaryViews(ofKind: <#T##String#>)
        //kind가 일치하는 view 중 collectionview에 표시되는 것만
        
        
        //header, footer는 delegate로 지정할 수 있다.
    }
}

extension SupplementaryViewViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        <#code#>
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        <#code#>
//    }
    //여기서 헤더 푸터 
}

extension SupplementaryViewViewController: UICollectionViewDataSource {
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print(#function, kind)
        switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
                header.sectionTitleLabel.text = list[indexPath.section].title
                return header
            case UICollectionView.elementKindSectionFooter:
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! FooterCollectionReusableView
                footer.sectionFooterLabel.text = list[indexPath.section].title
                return footer
            default:
                fatalError("unsupport Kind")
                break;
        }
       
    }
    
    
}








