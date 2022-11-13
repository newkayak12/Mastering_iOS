
import UIKit

class PageControlViewController: UIViewController {
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var pager: UIPageControl!
    
    
    let list = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.black]
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        listCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pager.numberOfPages = list.count
        pager.currentPage = 0
        
        pager.pageIndicatorTintColor = UIColor.systemGray3
        pager.currentPageIndicatorTintColor = UIColor.systemRed
    }
}

extension PageControlViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2.0)
        
        let newPage = Int(x / width)
        if( pager.currentPage != newPage ){
            pager.currentPage = newPage
        }
    }
}


extension PageControlViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = list[indexPath.item]
        return cell
    }
}


extension PageControlViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
