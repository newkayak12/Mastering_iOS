import UIKit

struct Development: Codable {
    let language: String
    let os: String
}

class PropertyListViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
   }
   
   @IBAction func loadFromBundle(_ sender: Any) {
       guard let url = Bundle.main.url(forResource: "data", withExtension: "plist") else {
           fatalError("not found")
       }
       
       if #available(iOS 11.0, *) {
           if let dict = try? NSArray(contentsOf: url, error: ()) {
               print(dict)
           }
       } else {
           if let dict = NSArray(contentsOf: url) {
               print(dict)
           }
       }
       
   }
   
    
    let fileUrl: URL = {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("data").appendingPathExtension("plist")
    }()
    
   @IBAction func loadFromDocuments(_ sender: Any) {
       do {
           let data = try Data(contentsOf: fileUrl)
           let decoder = PropertyListDecoder()
//           let dict = try decoder.decode([String:String].self, from: data)
           let dict = try decoder.decode(Development.self, from: data)
           
           print(dict)
       } catch {
           print(error)
       }
   }
   
   @IBAction func saveToDocuments(_ sender: Any) {
       do {
//           let dict = ["language":"Swift", "os":"iOS"]
           let dev = Development(language: "Swift", os: "iOS")
           let encoder = PropertyListEncoder()
           
//           let data = try encoder.encode(dict)
           let data = try encoder.encode(dev)
           try data.write(to: fileUrl)
           print("Done")
       } catch {
           print(error)
       }
   }
}
