import UIKit

class MultiSectionTableViewViewController: UIViewController {
    
    let list: [PhotosSettingSection] = PhotosSettingSection.generateData()
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    @objc func toggleHideAlbum(_ sender: UISwitch) {
        print(#function)
        list[1].items[0].on.toggle()
    }
    
    @objc func toggleAutoPlayVideos(_ sender: UISwitch) {
        print(#function)
        list[2].items[0].on.toggle()
    }
    
    @objc func toggleSummarizePhotos(_ sender: UISwitch) {
        print(#function)
        list[2].items[1].on.toggle()
    }
    
    @objc func toggleShowHolidayEvents(_ sender: UISwitch) {
        print(#function)
        list[3].items[1].on.toggle()
    }
    
    func showActionSheet() {
        let sheet = UIAlertController(title: nil, message: "Resetting will allow previously blocked people, places, dates, or holidays to once again be included in new Memories.", preferredStyle: .actionSheet)
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive, handler: nil)
        sheet.addAction(resetAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cancelAction)
        
        if let pc = sheet.popoverPresentationController {
            if let tbl = view.subviews.first(where: { $0 is UITableView }) as? UITableView {
                if let cell = tbl.cellForRow(at: IndexPath(row: 0, section: 3)) {
                    pc.sourceView = cell
                    pc.sourceRect = tbl.frame
                }
            }
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) //scene이 표시되기 직전에 실행
        if let selceted = listTableView.indexPathForSelectedRow {
            listTableView.deselectRow(at: selceted, animated: true)
        }
    }
}


extension MultiSectionTableViewViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let target = list[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: target.type.rawValue, for: indexPath)
        cell.textLabel?.text = target.title
        
        switch target.type {
            case .disclosure:
                cell.imageView?.image = UIImage(systemName: target.imageName ?? "")
            case .switch:
                if let switchView = cell.accessoryView as? UISwitch {
                    switchView.isOn = target.on
                    switchView.removeTarget(nil, action: nil, for: .valueChanged)
                    switch (indexPath.section, indexPath.row ){
                        case (1, 0):
                            switchView.addTarget(self, action: #selector(toggleHideAlbum(_:)), for: .valueChanged)
                        case (2, 0):
                            switchView.addTarget(self, action: #selector(toggleAutoPlayVideos(_:)), for: .valueChanged)
                        case (2, 1):
                            switchView.addTarget(self, action: #selector(toggleSummarizePhotos(_:)), for: .valueChanged)
                        case (3, 1):
                            switchView.addTarget(self, action: #selector(toggleShowHolidayEvents(_:)), for: .valueChanged)
                        default:
                            break;
                    }
                }
            case .action:
                break;
            case .checkmark:
                cell.accessoryType = target.on ? .checkmark : .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].header
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return list[section].footer
    }
    
    
}
extension MultiSectionTableViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row == 0 {
            showActionSheet()
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if indexPath.section == 4 {
            let otherRow: Int = indexPath.row == 0 ? 1 : 0
            if let cell = tableView.cellForRow(at: indexPath), let other = tableView.cellForRow(at: [4, otherRow]){

                
                list[indexPath.section].items[indexPath.row].on.toggle()
                list[indexPath.section].items[otherRow].on.toggle()
                cell.accessoryType = list[indexPath.section].items[indexPath.row].on ? .checkmark : .none
                other.accessoryType = list[indexPath.section].items[otherRow].on ? .checkmark : .none
            }
        }
        
    }
}







