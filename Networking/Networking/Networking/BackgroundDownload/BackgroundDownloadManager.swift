import UIKit

class BackgroundDownloadManager: NSObject {
   static let shared = BackgroundDownloadManager()
   private override init() {
      super.init()
   }
   
   static let didWriteDataNotification = Notification.Name(rawValue: "BackgroundDownloadManager.didWriteDataNotification")
   static let totalBytesWrittenKey = "totalBytesWritten"
   static let totalBytesExpectedToWriteKey = "totalBytesExpectedToWrite"
   
   var completionHandler: (()->())?
   
   var targetUrl: URL {
      guard let targetUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("backgroundFile.mp4") else {
         fatalError("Invalid File URL")
      }
      
      return targetUrl
   }
   
   lazy var session: URLSession = {
      let config = URLSessionConfiguration.background(withIdentifier: "SampleSession")
      
      let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
      return session
   }()
}

extension BackgroundDownloadManager: URLSessionDownloadDelegate {   
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      print(totalBytesWritten, totalBytesExpectedToWrite)
      
      // Code Input Point #3
       let userInfo = [BackgroundDownloadManager.totalBytesWrittenKey:totalBytesWritten, BackgroundDownloadManager.totalBytesExpectedToWriteKey: totalBytesExpectedToWrite]
       NotificationCenter.default.post(name: BackgroundDownloadManager.didWriteDataNotification, object: nil, userInfo: userInfo)
      // Code Input Point #3
   }
   
   func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
      NSLog(">> %@ %@", self, #function)
      print(error ?? "Done")
   }
   
   func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      NSLog(">> %@ %@", self, #function)
      
      guard (try? location.checkResourceIsReachable()) ?? false else {
         return
      }
      
      do {
         _ = try FileManager.default.replaceItemAt(targetUrl, withItemAt: location)
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   // Code Input Point #2
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        NSLog(">> %@ %@", self, #function)
        DispatchQueue.main.async {
            self.completionHandler?()
        }
    }
   // Code Input Point #2
}

