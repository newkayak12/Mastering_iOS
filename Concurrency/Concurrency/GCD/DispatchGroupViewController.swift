import UIKit

class DispatchGroupViewController: UIViewController {
   
   let workQueue = DispatchQueue(label: "WorkQueue", attributes: .concurrent)
   let serialWorkQueue = DispatchQueue(label: "SerialWorkQueue")
   
    
   let group = DispatchGroup()
   @IBAction func submit(_ sender: Any) {
//       group.enter()
       workQueue.async(group: group) {
         for _ in 0..<10 {
            print("🍏", separator: "", terminator: "")
            Thread.sleep(forTimeInterval: 0.1)
         }
//          group.leave()
      }

      workQueue.async(group: group) {
         for _ in 0..<10 {
            print("🍎", separator: "", terminator: "")
            Thread.sleep(forTimeInterval: 0.2)
         }
      }

      serialWorkQueue.async(group: group) {
         for _ in 0..<10 {
            print("🍋", separator: "", terminator: "")
            Thread.sleep(forTimeInterval: 0.3)
         }
      }
       
       group.notify(queue: DispatchQueue.main) {
           print("Done")
       }
   }
}

















