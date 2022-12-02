import UIKit

class PrefetchingViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    lazy var refreshControl: UIRefreshControl = { [weak self] in
        let control = UIRefreshControl()
        control.tintColor = self?.view.tintColor
        return control
    }()
    
    
    @objc func refresh() {
        DispatchQueue.global().async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.list = Landscape.generateData()
            strongSelf.downloadTasks.forEach { $0.cancel() }
            strongSelf.downloadTasks.removeAll()
            Thread.sleep(forTimeInterval: 2)
            
            DispatchQueue.main.async {
                strongSelf.listTableView.reloadData()
                strongSelf.listTableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    
    var list = Landscape.generateData()
    var downloadTasks = [URLSessionTask]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.prefetchDataSource = self
        listTableView.refreshControl = refreshControl //이러면 pull to refresh 활성화됨
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
}

extension PrefetchingViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            downloadImage(at: indexPath.row)
        }
        print(#function, indexPaths)
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        for indexPath in indexPaths {
            cancelDownload(at: indexPath.row)
        }
    }
}


extension PrefetchingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let imageView = cell.viewWithTag(100) as? UIImageView {
            if let image = list[indexPath.row].image {
                imageView.image = image
            } else {
                imageView.image = nil
                downloadImage(at: indexPath.row)
            }
        }
        
        if let label = cell.viewWithTag(200) as? UILabel {
            label.text = "#\(indexPath.row + 1)"
        }
        
        return cell
    }
}




extension PrefetchingViewController {
    func downloadImage(at index: Int) {
        guard list[index].image == nil else {
            return
        }
        
        let targetUrl = list[index].url
        guard !downloadTasks.contains(where: { $0.originalRequest?.url == targetUrl }) else {
            return
        }
        
        print(#function, index)
        
        let task = URLSession.shared.dataTask(with: targetUrl) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data, let image = UIImage(data: data), let strongSelf = self {
                strongSelf.list[index].image = image
                let reloadTargetIndexPath = IndexPath(row: index, section: 0)
                DispatchQueue.main.async {
                    if strongSelf.listTableView.indexPathsForVisibleRows?.contains(reloadTargetIndexPath) == .some(true) {
                        strongSelf.listTableView.reloadRows(at: [reloadTargetIndexPath], with: .automatic)
                    }
                }
                
                strongSelf.completeTask()
            }
        }
        task.resume()
        downloadTasks.append(task)
    }
    
    
    func completeTask() {
        downloadTasks = downloadTasks.filter { $0.state != .completed }
    }
    
    
    func cancelDownload(at index: Int) {
        let targetUrl = list[index].url
        guard let taskIndex = downloadTasks.index(where: { $0.originalRequest?.url == targetUrl }) else {
            return
        }
        let task = downloadTasks[taskIndex]
        task.cancel()
        downloadTasks.remove(at: taskIndex)
    }
}















