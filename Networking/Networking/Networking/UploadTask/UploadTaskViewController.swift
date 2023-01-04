import UIKit


class UploadTaskViewController: UIViewController {
   
   @IBOutlet weak var sizeLabel: UILabel!
   
   @IBOutlet weak var uploadProgressView: UIProgressView!
   
   lazy var formatter: ByteCountFormatter = {
      let f = ByteCountFormatter()
      f.countStyle = .file
      return f
   }()
   
   var dropboxUploadRequest: URLRequest {
      guard let apiUrl = URL(string: "https://content.dropboxapi.com/2/files/upload") else {
         fatalError("Invalid URL")
      }
      
      var request = URLRequest(url: apiUrl)
      request.httpMethod = "POST"
      request.setValue("Bearer \(dropBoxAccessToken)", forHTTPHeaderField: "Authorization")
      request.setValue("{\"path\": \"/intro.mp4\",\"mode\": \"overwrite\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}", forHTTPHeaderField: "Dropbox-API-Arg")
      request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
      
      return request
   }
   
   // Code Input Point #2
    var uploadTask: URLSessionUploadTask?
    
    lazy var session: URLSession = { [weak self] in
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
   // Code Input Point #2
   
   @IBAction func uploadWithProgress(_ sender: Any) {
      guard let resourceUrl = Bundle.main.url(forResource: "intro", withExtension: "mp4") else {
         fatalError("Invalid Resource")
      }
      
      guard let data = try? Data(contentsOf: resourceUrl) else {
         fatalError("Invalid Data")
      }
      
      uploadProgressView.progress = 0.0
   
      // Code Input Point #3
       uploadTask = session.uploadTask(with: dropboxUploadRequest, from: data)
       uploadTask?.resume()
      // Code Input Point #3
   }
   
   @IBAction func upload(_ sender: Any) {
      guard let resourceUrl = Bundle.main.url(forResource: "intro", withExtension: "mp4") else {
         fatalError("Invalid Resource")
      }
      
      guard let data = try? Data(contentsOf: resourceUrl) else {
         fatalError("Invalid Data")
      }
      
      // Code Input Point #1
       let task = URLSession.shared.uploadTask(with: dropboxUploadRequest, from: data) { data, response, error in
           if let error = error {
               self.showErrorAlert(with: error.localizedDescription)
               print(error)
               return
           }
           
           guard let httpResponse = response as? HTTPURLResponse else {
               self.showErrorAlert(with: "INVALID REPSONSE")
               return
           }
           
           guard (200...299).contains(httpResponse.statusCode) else {
               self.showErrorAlert(with: "\(httpResponse.statusCode)")
               return
           }
           
           guard let data = data, let str = String(data: data, encoding: .utf8) else {
               fatalError("INVALID DATA")
           }
           
           self.showErrorAlert(with: str)
       }
       
       task.resume()
      // Code Input Point #1
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)

      // Code Input Point #5
       session.invalidateAndCancel()
      // Code Input Point #5
   }
}

// Code Input Point #4
extension UploadTaskViewController: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {//upload
        let current = formatter.string(fromByteCount: totalBytesSent)
        let total = formatter.string(fromByteCount: totalBytesExpectedToSend)
        sizeLabel.text = "\(current)/\(total)"
        uploadProgressView.progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(error ?? "DONE")
    }
}
// Code Input Point #4
