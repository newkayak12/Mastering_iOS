
import UIKit

class EditModeViewController: UIViewController {
   
   var editingSwitch: UISwitch!
   @IBOutlet weak var listTableView: UITableView!
   
   var productList = ["iMac Pro", "iMac 5K", "Macbook Pro", "iPad Pro", "iPhone X", "Mac mini", "Apple TV", "Apple Watch"]
   var selectedList = [String]()
   
   @objc func toggleEditMode(_ sender: UISwitch) {
//       listTableView.isEditing.toggle()
       listTableView.setEditing(sender.isOn, animated:true)
   }
   
   @objc func emptySelectedList() {
       productList.append(contentsOf: selectedList)
       selectedList.removeAll()
       listTableView.reloadSections(IndexSet(integersIn: 0...1), with: .automatic)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      editingSwitch = UISwitch(frame: .zero)
      editingSwitch.addTarget(self, action: #selector(toggleEditMode(_:)), for: .valueChanged)
      
      let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(emptySelectedList))
      deleteButton.tintColor = UIColor.red
      
      navigationItem.rightBarButtonItems = [deleteButton, UIBarButtonItem(customView: editingSwitch)]
      editingSwitch.isOn = listTableView.isEditing
   }
}


extension EditModeViewController: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return 2
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      switch section {
      case 0:
         return selectedList.count
      case 1:
         return productList.count
      default:
         return 0
      }
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      switch indexPath.section {
      case 0:
         cell.textLabel?.text = selectedList[indexPath.row]
      case 1:
         cell.textLabel?.text = productList[indexPath.row]
      default:
         break
      }
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      switch section {
      case 0:
         return "Selected List"
      case 1:
         return "Product List"
      default:
         return nil
      }
   }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch (editingStyle){
            case .insert:
                //?????? ????????? ???????????? -> ????????? ??? ????????????
                let target = productList[indexPath.row]
                let insertIndexPath = IndexPath(row: selectedList.count, section: 0)
                selectedList.append(target)
                productList.remove(at: indexPath.row)
                
               
                //listTableView.beginUpdates() //?????? ??????, ????????? ??? beginUpdate??? ??????
                
//                listTableView.insertRows(at: [insertIndexPath], with: .automatic) //TableView??? ?????? ???????????? ?????? ????????? ????????? ???????????? ?????????
//                listTableView.deleteRows(at: [indexPath], with: .automatic) //???????????? ??????.
               
                //listTableView.endUpdates() //?????????. ????????? update -> end ?????? ????????? Batch ???????????? ????????????.
                
                
                listTableView.performBatchUpdates { [weak self] in //iOS 11?????? ????????? begin, end??? ?????? ?????? ?????????
                    
                    self?.listTableView.insertRows(at: [insertIndexPath], with: .automatic) //TableView??? ?????? ???????????? ?????? ????????? ????????? ???????????? ?????????
                    self?.listTableView.deleteRows(at: [indexPath], with: .automatic) //???????????? ??????.
                } completion: { (finished) in
                }
                
                
            case .delete:
                let target = selectedList[indexPath.row]
                let insertIndexPath = IndexPath(row: productList.count, section: 1)
                productList.append(target)
                selectedList.remove(at: indexPath.row)
                
                listTableView.beginUpdates()
                
                listTableView.insertRows(at: [insertIndexPath], with: .automatic)
                listTableView.deleteRows(at: [indexPath], with: .automatic)
                
                listTableView.endUpdates()
            default:
                break;
        }
    }
}


extension EditModeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        switch indexPath.section {
            case 0:
                return .delete
            case 1:
                return .insert
            default:
                return .none
        }
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {//swipe to delete ???????????? ??????
        editingSwitch.setOn(true, animated: true)
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        editingSwitch.setOn(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove "
    }
    
}


















