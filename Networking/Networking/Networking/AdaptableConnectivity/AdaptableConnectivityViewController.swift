import UIKit

class AdaptableConnectivityViewController: UIViewController {
   
   @IBOutlet weak var sizeLabel: UILabel!
   
   lazy var formatter: ByteCountFormatter = {
      let f = ByteCountFormatter()
      f.countStyle = .file
      return f
   }()
   
   lazy var session: URLSession = { [weak self] in
      let config = URLSessionConfiguration.default
      
      // Code Input Point #1
       config.waitsForConnectivity = true
       config.timeoutIntervalForRequest = 5
       //adaptableConnectivity가 활성화도히면 requestTimeOut은 무시된다.
       config.timeoutIntervalForResource = 5 //-2103
       /**
        request는 최초 응답을 기준으로 타입아웃 판단
        resource는 task 완료를 기준으로
        */
      // Code Input Point #1
      
      let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
      return session
      }()
   
   var task: URLSessionDownloadTask?
   
   @IBAction func startDownload(_ sender: Any) {
      guard let url = URL(string: smallFileUrlStr) else {
         fatalError("Invalid URL")
      }
      
      task = session.downloadTask(with: url)
      task?.resume()
   }
   
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      session.invalidateAndCancel()
   }
}

extension AdaptableConnectivityViewController: URLSessionDownloadDelegate {
   // Code Input Point #2
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        print(#function)
        sizeLabel.text = "WAITING..."
    }
   // Code Input Point #2
   
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      sizeLabel.text = "\(formatter.string(fromByteCount: totalBytesWritten))/\(formatter.string(fromByteCount: totalBytesExpectedToWrite))"
   }
   
   func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
      print(#function)
      // -1001, NSURLErrorTimedOut
      
      if let error = error {
         print(error)
         showErrorAlert(with: error.localizedDescription)
      }
   }
   
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      print(#function)
   }
}
