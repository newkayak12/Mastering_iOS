///
/// SESSION CONFIGURATION
/// TLS Levels
/// Cellular Usage
/// Network Service Type
/// Cookie Policies
/// Cache Polices
/// Storage Objects
/// Request Timeouts
/// Resource Timeouts
///
///
/// > Shared Session Configuration (SystemDefault)
/// > Default Session Configuration (SystemDefault + SessionDelegate + ResponseCaching) -> KeyChain에 인증정보 저장
/// > Ephemeral Session Configuration (SystemDefault + SessionDelegate + ResponseCaching(MemoryOnly))
/// > Background Session Configuartion (SystemDefault + SessionDelegate + BackgroundTransfer)
///
///

import UIKit

class SessionConfigurationViewController: UIViewController {
   
   @IBAction func useSharedConfiguration(_ sender: Any) {
      // Code Input Point #1
       sendReqeust(using: URLSession.shared)
      // Code Input Point #1
   }
   
   @IBAction func useDefaultConfiguration(_ sender: Any) {
      // Code Input Point #2
       sendReqeust(using: URLSession(configuration: .default))
      // Code Input Point #2
   }
   
   @IBAction func useEphemeralConfiguration(_ sender: Any) {
      // Code Input Point #3
       sendReqeust(using: URLSession(configuration: .ephemeral))
      // Code Input Point #3
   }
   
   @IBAction func useBackgroundConfiguration(_ sender: Any) {
      // Code Input Point #4
       sendReqeust(using: URLSession(configuration: .background(withIdentifier: "DownTask")))
      // Code Input Point #4
   }
   
   @IBAction func useCustomConfiguration(_ sender: Any) {
      // Code Input Point #5
       let configuration = URLSessionConfiguration.default
       configuration.timeoutIntervalForRequest = 30
       configuration.httpAdditionalHeaders = ["ZUMO-API-VERSION":"2.0.0"]
       configuration.networkServiceType = .responsiveData
       
       let session = URLSession(configuration: configuration)
       sendReqeust(using: session)
      // Code Input Point #5
   }
   
   func sendReqeust(using session: URLSession) {
      guard let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string") else {
         fatalError("Invalid URL")
      }
      
      let task = session.dataTask(with: url) { (data, response, error) in
         if let error = error {
            self.showErrorAlert(with: error.localizedDescription)
            print(error)
            return
         }
         
         guard let httpResponse = response as? HTTPURLResponse else {
            self.showErrorAlert(with: "Invalid Response")
            return
         }
         
         guard (200...299).contains(httpResponse.statusCode) else {
            self.showErrorAlert(with: "\(httpResponse.statusCode)")
            return
         }
         
         guard let data = data, let str = String(data: data, encoding: .utf8) else {
            fatalError("Invalid Data")
         }
         
         self.showInfoAlert(with: str)
      }
      
      task.resume()
   }
}
