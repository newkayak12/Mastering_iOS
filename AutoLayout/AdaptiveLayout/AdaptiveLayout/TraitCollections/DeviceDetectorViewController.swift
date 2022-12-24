
import UIKit

class DeviceDetectorViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var deviceImageView: UIImageView!
    @IBOutlet weak var deviceNameLabel: UILabel!

    func update() {
        var uiImage: UIImage? = UIImage(systemName: "questionmark.circle") ?? nil
        var text = "???"
        switch traitCollection.userInterfaceIdiom {
        case .unspecified:
            uiImage = UIImage(systemName: "questionmark.circle")
            text = "???"
        case .phone:
            uiImage = UIImage(named: "iPhone")
            text = "iPhone"
        case .pad:
            uiImage = UIImage(named: "iPad")
            text = "iPad"
        case .tv:
            uiImage = UIImage(named: "appleTv")
            text = "Apple Tv"
        case .carPlay:
            uiImage = UIImage(systemName: "car")
            text = "Car"
        case .mac:
            uiImage = UIImage(named: "iMac")
            text = "Mac"
        @unknown default:
            uiImage = UIImage(systemName: "questionmark.circle")
            text = "???"
        }
        deviceImageView.image = uiImage
        deviceNameLabel.text = text
    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        print(#function)
        //보통
        if newCollection.verticalSizeClass == .compact {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
        
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .systemIndigo
        } else {
            view.backgroundColor = .yellow
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //iPad 역시
        super.viewWillTransition(to: size, with: coordinator)
        if size.width > size.height {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print(#function)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
}
