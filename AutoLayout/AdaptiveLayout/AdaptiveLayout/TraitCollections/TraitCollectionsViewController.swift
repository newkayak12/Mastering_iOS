import UIKit

struct Item {
    let title: String
    let value: String
}

class TraitCollectionsViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    
    var list = [Item]()
    
    func update() {
        list.removeAll()
        /**
         UITraitEnvironment
            trailCollection
            traitCollectionDidChange
         
         UIContentContainer
            viewWillTransition
            willTransition
         */
        list.append(contentsOf: [
//            UITraitCollection.current
            Item(title: "Horizontal Size Class", value: traitCollection.horizontalSizeClass.description),
            Item(title: "Vertical Size Class", value: traitCollection.verticalSizeClass.description),
            Item(title: "Display Scale", value: "\(traitCollection.displayScale)"),
            Item(title: "Display Gamut", value: "\(traitCollection.displayGamut)"),
            Item(title: "Interface Style", value: "\(traitCollection.userInterfaceStyle.description)"),
            Item(title: "Interface Idiom", value: "\(traitCollection.userInterfaceIdiom.description)"),
        ])
     
        listTableView.reloadData()
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        update()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        update()
    }
}



extension TraitCollectionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].value
        return cell
    }
}

extension UIUserInterfaceSizeClass: CustomStringConvertible {
    public var description: String {
        switch self {
        case .regular:
            return "Regular"
        case .compact:
            return "Compact"
        case .unspecified:
            return "Unspecified"
        @unknown default:
            return "Unknown"
        }
    }
}

extension UIDisplayGamut: CustomStringConvertible {
    public var description: String {
        switch self {
        case .P3:
            return "P3"
        case .SRGB:
            return "SRGB"
        case .unspecified:
            return "Unspecified"
        @unknown default:
            return "Unknown"            
        }
    }
}

extension UIUserInterfaceStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        case .unspecified:
            return "Unspecified"
        @unknown default:
            return "Unknown"
        }
    }
}


extension UIUserInterfaceIdiom: CustomStringConvertible {
    public var description: String {
        switch self {
        case .phone:
            return "Phone"
        case .pad:
            return "Pad"
        case .tv:
            return "TV"
        case .carPlay:
            return "Car"
        case .mac:
            return "Mac"
        case .unspecified:
            return "Unspecified"
        @unknown default:
            return "Unknown"
        }
    }
}
