import UIKit

class TextPickerViewController: UIViewController {
    let devTools = ["Xcode", "Postman", "SourceTree", "Zeplin", "Android Studio", "SublimeText"]
    let fruits = ["Apple", "Orange", "Banana", "Kiwi", "Watermelon", "Peach", "Strawberry"]
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBAction func report(_ sender: Any) {
//        let row = picker.selectedRow(inComponent: 0)
//        guard row >= 0 else {
//            print("not found")
//            return
//        }
//        print(devTools[row])
        
        let firstSelectedRow = picker.selectedRow(inComponent: 0)
        let secondSelectedRow = picker.selectedRow(inComponent: 1)
        
        if firstSelectedRow >= 0 {
            print(devTools[firstSelectedRow])
        }
        if secondSelectedRow >= 0 {
            print(fruits[secondSelectedRow])
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension TextPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return devTools.count
        case 1:
            return fruits.count
        default:
            return 0
        }
    }
    
}
extension TextPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
            case 0:
                return devTools[row]
            case 1:
                return fruits[row]
            default:
                return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
            case 0:
                print(devTools[row])
            case 1:
                print(fruits[row])
            default:
                print("not found")
        }
    }
}
