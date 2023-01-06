import UIKit

class TaskSchedulingViewController: UIViewController {
   @IBOutlet weak var sizeLabel: UILabel!
   
   lazy var formatter: ByteCountFormatter = {
      let f = ByteCountFormatter()
      f.countStyle = .file
      return f
   }()
   
   var task: URLSessionDownloadTask?
   
   lazy var session: URLSession = { [weak self] in
      let config = URLSessionConfiguration.background(withIdentifier: "SampleSession")
      
      // Code Input Point #2
       config.isDiscretionary = true //iOS에 네트워크 통신에 대한 재량권을 부여(wifi연결까지 기다린다던가 하는)
      // Code Input Point #2
      
      let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
      return session
   }()
   
   @IBAction func startDownload(_ sender: Any) {
      guard let url = URL(string: bigFileUrlStr) else {
         fatalError("Invalid URL")
      }
      
      task = session.downloadTask(with: url)
      
      // Code Input Point #1
       task?.earliestBeginDate = Date(timeIntervalSinceNow: 5) //이러면 약 5초 이후에 실행
       task?.countOfBytesClientExpectsToSend = 80 //네트워크 최적화의 힌트
       task?.countOfBytesClientExpectsToReceive = 1024 * 1024 * 40//네트워크 최적화의 힌트로 판단
       
       sizeLabel.text = "Delayed..."
      // Code Input Point #1
      
      task?.resume()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      session.invalidateAndCancel()
   }
}


extension TaskSchedulingViewController: URLSessionDownloadDelegate {
   // Code Input Point #3
    //delay된 task가 실행되기 직전에 실행
    func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest request: URLRequest, completionHandler: @escaping (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {
        DispatchQueue.main.async {
            self.sizeLabel.text = "GO!"
        }
        completionHandler(.continueLoading, nil)
    }
   // Code Input Point #3
   
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      sizeLabel.text = "\(formatter.string(fromByteCount: totalBytesWritten))/\(formatter.string(fromByteCount: totalBytesExpectedToWrite))"
   }
   
   func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
      print(#function)
      print(error ?? "Done")
   }
   
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      print(#function)
   }
}
