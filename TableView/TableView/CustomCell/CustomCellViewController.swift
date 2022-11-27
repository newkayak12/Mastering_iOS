import UIKit


class CustomCellViewController: UIViewController {
    
    let list = WorldTime.generateData()
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "SharedCustomCell", bundle: nil)
        listTableView.register(cellNib, forCellReuseIdentifier: "SharedCustomCell")
    }
}




extension CustomCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TimeTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharedCustomCell", for: indexPath) as! TimeTableViewCell
        
        let target = list[indexPath.row]
        
        cell.dateLabel.text = "\(target.date), \(target.hoursFromGMT)시간"
        cell.locationLabel.text = target.location
        cell.ampmLabel.text = target.ampm
        cell.timeLabel.text = target.time
        
        
//        cell.textLabel?.text = target.location
//        cell.detailTextLabel?.text = "\(target.date) \(target.time)"
//        if let dateLabel = cell.viewWithTag(100) as? UILabel {
//            dateLabel.text = "\(target.date), \(target.hoursFromGMT)시간"
//        }
//        if let locationLabel = cell.viewWithTag(200) as? UILabel {
//            locationLabel.text = target.location
//        }
//        if let ampmLabel = cell.viewWithTag(300) as? UILabel {
//            ampmLabel.text = target.ampm
//        }
//        if let timeLabel = cell.viewWithTag(400) as?  UILabel {
//            timeLabel.text = target.time
//        }
        
        return cell
    }
}
