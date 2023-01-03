
import UIKit

class URLRequestViewController: UIViewController {
   
   @IBOutlet weak var imageView: UIImageView!
   
   @IBAction func sendRequest(_ sender: Any) {
      imageView.image = nil
      
      // Code Input Point #1
       guard let url = URL(string: picUrlStr) else { fatalError("Invalid URL") }
       
//       do {
//           let data = try Data(contentsOf: url)
//           imageView.image = UIImage(data: data)
//       } catch {
//           print(error)
//       }
       
       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
           print(data, response, error)
//           print("data: \(data) \n response: \(response) \n error \(error)")
           if let error = error {
               print(error)
               
           } else if let data = data {
               print("WORK")
               let image = UIImage(data: data)
               DispatchQueue.main.async {
                   self.imageView.image = image
               }
           }
       }
       task.resume()
      // Code Input Point #1
   }
}
