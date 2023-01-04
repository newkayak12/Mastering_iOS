import UIKit
import AVKit

class DownloadTaskViewController: UIViewController {
   
   @IBOutlet weak var sizeLabel: UILabel!
   
   @IBOutlet weak var downloadProgressView: UIProgressView!
   
   lazy var formatter: ByteCountFormatter = {
      let f = ByteCountFormatter()
      f.countStyle = .file
      return f
   }()
   
   var targetUrl: URL {
      guard let targetUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("downloadedFile.mp4") else {
         fatalError("Invalid File URL")
      }
      
      return targetUrl
   }
   
   // Code Input Point #1
    var task: URLSessionDownloadTask?
    lazy var session: URLSession = { [weak self] in
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
   // Code Input Point #1
   
   @IBAction func startDownload(_ sender: Any) {
      do {
         let hasFile = try targetUrl.checkResourceIsReachable()
         if hasFile {
            try FileManager.default.removeItem(at: targetUrl)
         }
      } catch {
         print(error)
      }
      
      guard let url = URL(string: bigFileUrlStr) else { // 나중에서 수정
         fatalError("Invalid URL")
      }
      
      downloadProgressView.progress = 0.0
      
      // Code Input Point #2
       task = session.downloadTask(with: url)
       task?.resume()
      // Code Input Point #2
   }
   
   @IBAction func stopDownload(_ sender: Any) {
      // Code Input Point #4
       task?.cancel()
      // Code Input Point #4
   }
   
   
   // Code Input Point #5
    var resumeData: Data?
   // Code Input Point #5
   
   @IBAction func pauseDownload(_ sender: Any) {
      // Code Input Point #6
       task?.cancel(byProducingResumeData: { data in
           dump(data)
           self.resumeData = data
       })
      // Code Input Point #6
   }
   
   @IBAction func resumeDownload(_ sender: Any) {
      // Code Input Point #7
       guard let data = resumeData else {
           return
       }
       
       task = session.downloadTask(withResumeData: data)
       task?.resume()
      // Code Input Point #7
   }
   
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      return (try? targetUrl.checkResourceIsReachable()) ?? false
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let playerVC = segue.destination as? AVPlayerViewController {
         let player = AVPlayer(url: targetUrl)
         playerVC.player = player
         playerVC.navigationItem.title = "Play"
      }
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      // Code Input Point #8
       session.invalidateAndCancel()
      // Code Input Point #8
   }
}

// Code Input Point #3
extension DownloadTaskViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let current = formatter.string(fromByteCount: totalBytesWritten)
        let total = formatter.string(fromByteCount: totalBytesExpectedToWrite)
        sizeLabel.text = "\(current) / \(total)"
        downloadProgressView.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("resume", fileOffset, expectedTotalBytes)
    }
    
    //끝났는지 여부
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(#function)
        print(error ?? "Done")
    }
    
    //temp 에서 파일 저장
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print(#function)
        
        guard ( try? location.checkResourceIsReachable() ) ?? false else {
            return
        }
        
        do {
            _ = try FileManager.default.replaceItemAt(targetUrl, withItemAt: location)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
// Code Input Point #3
