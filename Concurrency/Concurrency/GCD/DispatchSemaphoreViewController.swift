import UIKit

class DispatchSemaphoreViewController: UIViewController {
   
   var value = 0
   
   @IBOutlet weak var valueLabel: UILabel!
   
   let workQueue = DispatchQueue(label: "WorkQueue", attributes: .concurrent)
   let group = DispatchGroup()
   
   @IBAction func synchronize(_ sender: Any) {
      value = 0
      valueLabel.text = "\(value)"
      let sem = DispatchSemaphore(value: 1)
      workQueue.async(group: group) {
         for _ in 1...1000 {
             sem.wait()
             self.value += 1
             sem.signal()
         }
      }
      
      workQueue.async(group: group) {
         for _ in 1...1000 {
             sem.wait()
             self.value += 1
             sem.signal()
         }
      }
      
      workQueue.async(group: group) {
         for _ in 1...1000 {
             sem.wait()
             self.value += 1
             sem.signal()
         }
      }
      
      group.notify(queue: DispatchQueue.main) {
         self.valueLabel.text = "\(self.value)"
      }
   }
   
   @IBAction func controlExecutionOrder(_ sender: Any) {
      value = 0
      valueLabel.text = "\(value)"
      let sem = DispatchSemaphore(value: 0)
      workQueue.async {
         for _ in 1...100 {
            self.value += 1
            Thread.sleep(forTimeInterval: 0.1)
         }
          sem.signal()
      }
      
      DispatchQueue.main.async {
          sem.wait()//mainQueue에서 이러면 mainQueue가 블로킹됨
         self.valueLabel.text = "\(self.value)"
      }
   }
}
















