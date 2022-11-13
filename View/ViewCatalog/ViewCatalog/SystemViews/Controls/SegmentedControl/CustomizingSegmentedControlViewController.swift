
import UIKit

class CustomizingSegmentedControlViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var titleField: UITextField!
    
    @IBAction func insertSegment(_ sender: Any) {
        guard let title = titleField.text, title.count > 0 else {
            return
        }
        segmentedControl.insertSegment(withTitle: title, at: segmentedControl.numberOfSegments, animated: true)
        titleField.text = nil
    }
    
    
    @IBAction func removeSegment(_ sender: Any) {
        guard let title = titleField.text, title.count > 0 else {
            return
        }
        for index in 0 ..< segmentedControl.numberOfSegments {
            if let currentTitle = segmentedControl.titleForSegment(at: index),
               currentTitle == title {
                segmentedControl.removeSegment(at: index , animated: true)
                break;
            }
        }
        titleField.text = nil
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let normalImage = UIImage(named: "segment_normal")
//        let selectedImage = UIImage(named: "segment_selected")
//
//        segmentedControl.setBackgroundImage(normalImage, for: .normal, barMetrics: .default)
//        segmentedControl.setBackgroundImage(selectedImage, for: .selected, barMetrics: .default)
//
//
//        var img = UIImage(named: "segment_normal_normal")
//        print(img?.size)
//        segmentedControl.setDividerImage(img, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
//
//        let halfWidth = (img!.size.width - 20) / 3.0
//        var offset = UIOffset(horizontal: halfWidth, vertical: 0.0)
//        segmentedControl.setContentPositionAdjustment(offset, forSegmentType: .left, barMetrics: .default)
//
//        img = UIImage(named: "segment_normal_selected")
//        segmentedControl.setDividerImage(img, forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
//
//        img = UIImage(named: "segment_selected_normal")
//        segmentedControl.setDividerImage(img, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
//
        
        let normalImage = UIImage(named: "segment_normal")
        let selectedImage = UIImage(named: "segment_selected")
        
        segmentedControl.setBackgroundImage(normalImage, for: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(selectedImage, for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(normalImage, for: .highlighted, barMetrics: .default)
        
        segmentedControl.setDividerImage(UIImage(named: "segment_normal_normal"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(named: "segment_normal_selected"), forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(named: "segment_selected_normal"), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(named: "segment_normal_selected"), forLeftSegmentState: .highlighted, rightSegmentState: .selected, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(named: "segment_selected_normal"), forLeftSegmentState: .selected, rightSegmentState: .highlighted, barMetrics: .default)
        
        
        
        let width = (UIImage(named: "segment_normal_normal")!.size.width - 20 ) / 3.0
        var offset = UIOffset(horizontal: width, vertical: 0)
        segmentedControl.setContentPositionAdjustment(offset, forSegmentType: .left, barMetrics: .default)
        offset = UIOffset(horizontal: -width, vertical: 0)
        segmentedControl.setContentPositionAdjustment(offset, forSegmentType: .right, barMetrics: .default)
        
    }
}


















