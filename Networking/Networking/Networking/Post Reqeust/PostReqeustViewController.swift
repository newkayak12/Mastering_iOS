import UIKit

struct PostData: Codable {
   let a: Int
   let b: Int
   let op: String
}

class PostReqeustViewController: UIViewController {
   
   @IBOutlet weak var leftField: UITextField!
   @IBOutlet weak var rightField: UITextField!
   
   func encodedData() -> Data? {
      guard let leftStr = leftField.text, let a = Int(leftStr) else {
         showErrorAlert(with: "Please input only the number.")
         return nil
      }
      
      guard let rightStr = rightField.text, let b = Int(rightStr) else {
         showErrorAlert(with: "Please input only the number.")
         return nil
      }
      
      let data = PostData(a: a, b: b, op: "+")
      
      let encoder = JSONEncoder()
      return try? encoder.encode(data)
   }
   
   @IBAction func sendPostRequest(_ sender: Any) {
      guard let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/calc") else {
         fatalError("Invalid URL")
      }
      // Code Input Point #1
      var request = URLRequest(url: url)
       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       request.httpMethod = "POST"
       request.httpBody = encodedData()
       
       let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
           if let error = error {
               self.showErrorAlert(with: error.localizedDescription)
               print(error)
               return
           }
           
           guard let httpResponse = response as? HTTPURLResponse else {
               self.showErrorAlert(with: "INVALID RESPONSE")
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
}
