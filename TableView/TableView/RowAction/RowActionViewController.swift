import UIKit
import MessageUI

class RowActionViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var list = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
    
    
    func sendEmail(with data: String) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject("Test Mail")
        composer.setMessageBody(data, isHTML: false)
        
        present(composer, animated: true, completion: nil)
    }
    
    
    func sendMessage(with data: String) {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        
        let composer = MFMessageComposeViewController()
        composer.messageComposeDelegate = self
        composer.body = data
        
        present(composer, animated: true, completion: nil)
    }
    
    
    func delete(at indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        listTableView.deleteRows(at: [indexPath], with: .automatic)
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}



extension RowActionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //Edit관련 -> RowAction == edit
        
        return indexPath.row != 0
    }
}




extension RowActionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let emailAction = UITableViewRowAction(style: .default, title: "Email") { [weak self] (action, indexPath) in
            if let data = self?.list[indexPath.row]{
                self?.sendEmail(with: data)
            }
        }
        emailAction.backgroundColor = .black
        //backGround는 가능하나 fontColor 등은 바꿀 수 없다.
        
        
        let messageAction = UITableViewRowAction(style: .normal, title: "SMS") { [weak self] (action, indexPath) in
            if let data = self?.list[indexPath.row]{
                self?.sendMessage(with: data)
            }
        }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {[weak self]  (action, indexPath) in
                self?.delete(at: indexPath)
        }
        
        return [ deleteAction, messageAction,emailAction]
    }
    
}




extension RowActionViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}




extension RowActionViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}


















