import UIKit

class SessionDelegateTableViewController: UITableViewController {
   
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var descLabel: UILabel!
   
   var session: URLSession!
   
   // Code Input Point #3
   /**
            URLSessionDelegate
(INHERIT)      ᄂ URLSessionTaskDelegate
(INHERIT)          ᄂ URLSessionDataDelegate
                   ᄂ URLSessionDownloadDelegate
    */
    var buffer: Data?
   // Code Input Point #3
   
   @IBAction func sendReqeust(_ sender: Any) {
      guard let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/books/3") else {
         fatalError("Invalid URL")
      }
      
      // Code Input Point #1
       let configuration = URLSessionConfiguration.default
       session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
       let task = session.dataTask(with: url)
       task.resume()
       
       buffer = Data()
      // Code Input Point #1
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      // Code Input Point #6
//       session.finishTasksAndInvalidate() //flush
       session.invalidateAndCancel() // stop
      // Code Input Point #6
   }
}

// Code Input Point #2
extension SessionDelegateTableViewController: URLSessionDataDelegate { //openConnection
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            completionHandler(.cancel)
            return
        }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) { //transfer
        dump(data)
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            showErrorAlert(with: error.localizedDescription)
        } else {
            parse()
        }
    }
}
// Code Input Point #2

extension SessionDelegateTableViewController {
   func parse() {
      // Code Input Point #4
      
       guard let data = buffer else {
           fatalError("Invalid Buffer")
       }
      // Code Input Point #4
      
      let decoder = JSONDecoder()
      
      decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
         let container = try decoder.singleValueContainer()
         let dateStr = try container.decode(String.self)
         
         let formatter = ISO8601DateFormatter()
         formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
         return formatter.date(from: dateStr)!
      })
      
      // Code Input Point #5
      
       do {
           let detail = try decoder.decode(BookDetail.self, from: data)
           if detail.code == 200 {
               titleLabel.text = detail.book.title
               descLabel.text = detail.book.desc
               tableView.reloadData()
           }  else {
               showErrorAlert(with: detail.message ?? "ERROR!!")
           }
       } catch {
           showErrorAlert(with: error.localizedDescription)
           print(error)
       }
      // Code Input Point #5
   }
}
