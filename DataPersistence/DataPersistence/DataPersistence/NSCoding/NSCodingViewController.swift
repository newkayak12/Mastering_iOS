import UIKit
// MARK: - NSObject, NSCoding // encodable, decodable protocol을 채택하든
class Language: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    func encode(with coder: NSCoder) { //항상 클래스 형식으로 인코딩 - 디코딩해야 한다.
//        coder.encode(name, forKey: "name")
        coder.encode(name as NSString, forKey: "name")
//        coder.encode(version, forKey: "version")
        coder.encode(version as NSNumber, forKey: "version")
        coder.encode(logo, forKey: "logo")
    }
    
    required init?(coder: NSCoder) {
//        guard let name = coder.decodeObject(forKey: "name") as? String else { return nil }
//        self.name = name
        guard let name = coder.decodeObject(of: NSString.self, forKey: "name") else { return nil }
        self.name = name as String
        
//        self.version = coder.decodeDouble(forKey: "version")
        guard let version = coder.decodeObject(of: NSNumber.self, forKey: "version") else {return nil}
        self.version =  version.doubleValue
        
//        guard let logo = coder.decodeObject(forKey: "logo") as? UIImage else { return  nil}
//        self.logo = logo
        guard let logo = coder.decodeObject(of: UIImage.self, forKey: "logo") else { return  nil}
        self.logo = logo
    }
    
   let name: String
   let version: Double
   let logo: UIImage
   
   init(name: String, version: Double, logo: UIImage) {
      self.name = name
      self.version = version
      self.logo = logo
   }
}


class NSCodingViewController: UIViewController {
   
   @IBOutlet weak var imageView: UIImageView!
   
   @IBOutlet weak var nameLabel: UILabel!
   
   @IBOutlet weak var versionLabel: UILabel!
   
   let fileUrl: URL = {
      let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
      return documentsDirectory.appendingPathComponent("swift").appendingPathExtension("data")
   }()
   
   
   @IBAction func encodeObject(_ sender: Any) {
       do {
           guard let url = Bundle.main.url(forResource: "swiftlogo", withExtension: "png") else { return }
           let data = try Data(contentsOf: url)
           guard let img = UIImage(data: data) else { return }
           
           let obj =  Language(name: "Swift", version: 5.3, logo: img)
           
           
           if #available(iOS 11.0, *) {
               let archivedData = try NSKeyedArchiver.archivedData(withRootObject: obj, requiringSecureCoding: true)
               try archivedData.write(to: fileUrl)
           } else {
               NSKeyedArchiver.archiveRootObject(obj, toFile: fileUrl.path)
           }
           
           
           
           
           print("Done")
       } catch {
           print(error)
       }
   }
   
   
   @IBAction func decodeObject(_ sender: Any) {
       do {
           let data = try Data(contentsOf: fileUrl)
           var language:Language?
           if #available(iOS 11.0, *) {
               language = try NSKeyedUnarchiver.unarchivedObject(ofClass: Language.self, from: data)
           } else {
                language = NSKeyedUnarchiver.unarchiveObject(with: data) as? Language
           }
           
           
           
           if let language = language {
               self.imageView.image = language.logo
               self.nameLabel.text = language.name
               self.versionLabel.text = "\(language.version)"
           }
       } catch {
           print(error)
       }
   }
}
