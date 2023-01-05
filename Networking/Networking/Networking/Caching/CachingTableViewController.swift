/**
 useProtocolCachePolicy
 reloadIgnoringLocalCacheData
 returnCacheDataDontLoad
 returnCacheDataElseLoad
 */
import UIKit


class CachingTableViewController: UITableViewController {
   
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var descLabel: UILabel!
   @IBOutlet weak var lastUpdateDateLabel: UILabel!
   
   var buffer: Data?
   
   var lastDate = Date()
   
   lazy var formatter: ByteCountFormatter = {
      let f = ByteCountFormatter()
      f.countStyle = .file
      return f
   }()
   
   lazy var dateFormatter: DateFormatter = {
      let f = DateFormatter()
      f.dateFormat = "HH:mm:ss.SSS"
      return f
   }()
   
   lazy var session: URLSession = { [weak self] in
      let config = URLSessionConfiguration.default
      
      // Code Input Point #3
       config.requestCachePolicy = .reloadIgnoringLocalCacheData
      //request의 캐싱 정책이 우선순위가 높다.
      // Code Input Point #3
      
      let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
      return session
      }()
   
   @IBAction func sendRequestCacheControl(_ sender: Any) {
      guard let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/cache") else {
         fatalError("Invalid URL")
      }
      
      print(#function)
      
      buffer = Data()
      
      var request = URLRequest(url: url)
      
      // Code Input Point #1
//       request.cachePolicy = .returnCacheDataElseLoad
      // Code Input Point #1
      
      let task = session.dataTask(with: request)
      task.resume()
   }
   
   @IBAction func sendReqeust(_ sender: Any) {
      guard let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/cache/nocache") else {
         fatalError("Invalid URL")
      }
      
      print(#function)
      
      buffer = Data()
      
      var request = URLRequest(url: url)
      request.cachePolicy = .returnCacheDataElseLoad
      
      // Code Input Point #2
       if lastDate.timeIntervalSinceNow < -5 {
           request.cachePolicy = .reloadIgnoringLocalCacheData
           lastDate = Date()
       } else {
           request.cachePolicy = .returnCacheDataElseLoad
       }
      // Code Input Point #2
      
      let task = session.dataTask(with: request)      
      task.resume()
   }
   
   @IBAction func removeAllCache(_ sender: Any) {
      // Code Input Point #5
       print(#function)
       session.configuration.urlCache?.removeAllCachedResponses()
      // Code Input Point #5
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      session.invalidateAndCancel()
   }
}

extension CachingTableViewController: URLSessionDataDelegate {
   // Code Input Point #4
    //서버 응답을 캐싱하기 전에 호출 이 메소드를 구현하지 않으면 디스크/메모리에 모두 저장됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        guard let url = proposedResponse.response.url else {
            completionHandler(nil)
            return
        }
        
        if url.host == "kxcoding-study.azurewebsites.net"{
            completionHandler(proposedResponse)
        } else if url.scheme == "https" {
            let response = CachedURLResponse(response: proposedResponse.response, data: proposedResponse.data, userInfo: proposedResponse.userInfo, storagePolicy: URLCache.StoragePolicy.allowedInMemoryOnly)
            completionHandler(response)
        } else {
            let response = CachedURLResponse(response: proposedResponse.response, data: proposedResponse.data, userInfo: proposedResponse.userInfo, storagePolicy: .notAllowed)
            completionHandler(response)
        }
    }
   // Code Input Point #4
   
   func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
      guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
         completionHandler(.cancel)
         return
      }
      
      completionHandler(.allow)
   }
   
   func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
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

extension CachingTableViewController {
   func parse() {
      guard let data = buffer else {
         fatalError("Invalid Buffer")
      }

      let decoder = JSONDecoder()

      decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
         let container = try decoder.singleValueContainer()
         let dateStr = try container.decode(String.self)

         let formatter = ISO8601DateFormatter()
         formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
         return formatter.date(from: dateStr)!
      })

      do {
         let detail = try decoder.decode(BookDetail.self, from: data)

         if detail.code == 200 {
            titleLabel.text = detail.book.title
            descLabel.text = detail.book.desc

            let date = dateFormatter.string(from: Date())
            lastUpdateDateLabel.text = "Last Update\n\(date)"
            tableView.reloadData()
         } else {
            showErrorAlert(with: detail.message ?? "Error")
         }
      } catch {
         showErrorAlert(with: error.localizedDescription)
         print(error)
      }
   }
}

