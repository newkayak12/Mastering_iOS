import UIKit

struct CodableLanguage: Codable {
   let name: String
   let version: Double
   let logo: Data
}


class CodableViewController: UIViewController {
   
   @IBOutlet weak var imageView: UIImageView!
   
   @IBOutlet weak var nameLabel: UILabel!
   
   @IBOutlet weak var versionLabel: UILabel!
   
   let fileUrl: URL = {
      let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
      return documentsDirectory.appendingPathComponent("ios").appendingPathExtension("data")
   }()
   
   @IBAction func encodeObject(_ sender: Any) {
      do {
         guard let url = Bundle.main.url(forResource: "ioslogo", withExtension: "png") else {
            return
         }
         
         let data = try Data(contentsOf: url)
         
         let obj = CodableLanguage(name: "iOS", version: 12.0, logo: data)
         
          
         let archiver: NSKeyedArchiver
          
          if #available(iOS 11.0, *){
              archiver = NSKeyedArchiver(requiringSecureCoding: true)
          } else {
              archiver = NSKeyedArchiver()
              archiver.requiresSecureCoding = true
          }
          
          try archiver.encodeEncodable(obj, forKey: NSKeyedArchiveRootObjectKey)
          try archiver.encodedData.write(to: fileUrl)
         
          archiver.finishEncoding()//flush
          print("Done")
      } catch {
         print(error)
      }
   }
   
   
   @IBAction func decodeObject(_ sender: Any) {
       do {
           let data = try Data(contentsOf: fileUrl)
           
           var language: CodableLanguage?
           
           let unarchiver: NSKeyedUnarchiver?
           
           if #available(iOS 11.0, *) {
               unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
           } else {
               unarchiver = NSKeyedUnarchiver(forReadingWith: data)
           }
           unarchiver?.requiresSecureCoding = true
           
           language = unarchiver?.decodeDecodable(CodableLanguage.self, forKey: NSKeyedArchiveRootObjectKey)
           
           unarchiver?.finishDecoding()
         if let language = language {
            self.imageView.image = UIImage(data: language.logo)
            self.nameLabel.text = language.name
            self.versionLabel.text = "\(language.version)"
         }
      } catch {
         print(error)
      }
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}
