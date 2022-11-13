import UIKit

class ImagePickerViewController: UIViewController {
    
    lazy var images: [UIImage] = {
        return (0...6).compactMap { UIImage(named: "slot-machine-\($0)") }
    }()
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func shuffle(_ sender: Any?) {
        let firstIndex = Int.random(in: 0..<images.count) + images.count
        let secondIndex = Int.random(in: 0..<images.count) + images.count
        let thirdIndex = Int.random(in: 0..<images.count) + images.count
        
        picker.selectRow(firstIndex, inComponent: 0, animated: true)
        picker.selectRow(secondIndex, inComponent: 1, animated: true)
        picker.selectRow(thirdIndex, inComponent: 2, animated: true)
        
        
        if(firstIndex == secondIndex && secondIndex == thirdIndex){
            print("JACKPOT")
        } else {
            print("Fail")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.isUserInteractionEnabled = false
        
        picker.reloadAllComponents()
        shuffle(nil)
    }
}
extension ImagePickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count * 3 //무한 스크롤?
    }
}
extension ImagePickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let imageView = view as? UIImageView {
            imageView.image = images[row % images.count]
            return imageView
        }
        
        let imageView = UIImageView()
        imageView.image = images[row % images.count]
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
}


