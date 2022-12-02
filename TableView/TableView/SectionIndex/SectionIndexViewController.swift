import UIKit

class SectionIndexViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let list = Region.generateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.sectionIndexColor = UIColor.systemBlue
        listTableView.sectionIndexBackgroundColor = UIColor.secondarySystemBackground
        listTableView.sectionIndexTrackingBackgroundColor = UIColor.systemYellow
    }
}




extension SectionIndexViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].countries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = list[indexPath.section].countries[indexPath.row]
        cell.textLabel?.text = target
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        return list.map { $0.title }
        return stride(from: 0, to: list.count, by: 2).map { list[$0].title }
        //표시되는 순서에 맞게 그냥 스크롤되는 것일 뿐 따라서 스크롤도 맞춰줘야할 것같음
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index * 2;
    }
}










