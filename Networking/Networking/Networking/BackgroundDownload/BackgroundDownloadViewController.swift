import UIKit

class BackgroundDownloadViewController: UIViewController {
   
   @IBOutlet weak var sizeLabel: UILabel!
   @IBOutlet weak var recentDownloadLabel: UILabel!
   
   lazy var sizeFormatter: ByteCountFormatter = {
      let f = ByteCountFormatter()
      f.countStyle = .file
      return f
   }()
   
   lazy var dateFormatter: DateFormatter = {
      let f = DateFormatter()
      f.dateFormat = "MM/dd HH:mm:ss.SSS"
      return f
   }()
   
   var token: NSObjectProtocol?
   
   var targetUrl: URL {
//      guard let targetUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("backgroundFile.mp4") else {
//         fatalError("Invalid File URL")
//      }
//
//      return targetUrl
       return BackgroundDownloadManager.shared.targetUrl
   }
   
   var task: URLSessionDownloadTask?
   
//   lazy var session: URLSession = { [weak self] in
//      // Code Input Point #1
//
//      let config = URLSessionConfiguration.background(withIdentifier: "SampleSession")
//
//      // Code Input Point #1
//
//      let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
//      return session
//   }()
    
    let session = BackgroundDownloadManager.shared.session
   
   
   @IBAction func startDownload(_ sender: Any) {
      do {
         let hasFile = try targetUrl.checkResourceIsReachable()
         if hasFile {
            try FileManager.default.removeItem(at: targetUrl)
            print("Removed")
         }
      } catch {
         print(error.localizedDescription)
      }
      updateRecentDownload()
      
      guard let url = URL(string: smallFileUrlStr) else {
         fatalError("Invalid URL")
      }
      
      task = session.downloadTask(with: url)
      task?.resume()
   }
   
   @IBAction func stopDownload(_ sender: Any) {
      session.invalidateAndCancel()
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      _ = session
      updateRecentDownload()
      
      // Code Input Point #4
       token = NotificationCenter.default.addObserver(forName: BackgroundDownloadManager.didWriteDataNotification, object: nil, queue: OperationQueue.main, using: { noti in
           guard let userInfo = noti.userInfo else {return}
           guard let downloadSize = userInfo[BackgroundDownloadManager.totalBytesWrittenKey] as? Int64 else {return}
           guard let totalSize = userInfo[BackgroundDownloadManager.totalBytesExpectedToWriteKey] as? Int64 else {return}
           
           self.sizeLabel.text = "\(self.sizeFormatter.string(fromByteCount: downloadSize)) / \(self.sizeFormatter.string(fromByteCount: totalSize))"
       })
      // Code Input Point #4
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      session.invalidateAndCancel()
      
      if let token = token {
         NotificationCenter.default.removeObserver(token)
      }
   }
}


//extension BackgroundDownloadViewController: URLSessionDownloadDelegate {
//   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//      sizeLabel.text = "\(sizeFormatter.string(fromByteCount: totalBytesWritten))/\(sizeFormatter.string(fromByteCount: totalBytesExpectedToWrite))"
//   }
//
//   func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//      NSLog(">> %@ %@", self, #function)
//      print(error ?? "Done")
//   }
//
//   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//      NSLog(">> %@ %@", self, #function)
//
//      do {
//         _ = try FileManager.default.replaceItemAt(targetUrl, withItemAt: location)
//      } catch {
//         print(error)
//         fatalError(error.localizedDescription)
//      }
//      updateRecentDownload()
//   }
//}
//
//
extension BackgroundDownloadViewController {
   func updateRecentDownload() {
      do {
         let hasFile = try targetUrl.checkResourceIsReachable()
         if hasFile {
            let values = try targetUrl.resourceValues(forKeys: [.fileSizeKey, .creationDateKey])
            if let size = values.fileSize, let date = values.creationDate {
               recentDownloadLabel.text = "\(dateFormatter.string(from: date)) / \(sizeFormatter.string(fromByteCount: Int64(size)))"
            }
         }
      } catch {
         recentDownloadLabel.text = "Not Found / Unknown"
      }
   }
}
