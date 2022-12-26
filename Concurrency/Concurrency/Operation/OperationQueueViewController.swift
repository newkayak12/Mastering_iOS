
import UIKit

class OperationQueueViewController: UIViewController {
   
//   fileprivate let queue = OperationQueue.main
   fileprivate let queue = OperationQueue() //background
   var isCancelled = false
    
    
   @IBAction func startOperation(_ sender: Any) {
       isCancelled = false
       
       queue.addOperation {
           autoreleasepool {
               for _ in 1..<100 {
                   guard !self.isCancelled else {return}
                   print("🍏", separator: " ", terminator: " ")
                   Thread.sleep(forTimeInterval: 0.3)
               }
           }
       }
       
       let op = BlockOperation {
           autoreleasepool {
               for _ in 1..<100 {
                   guard !self.isCancelled else {return}
                   print("🍎", separator: " ", terminator: " ")
                   Thread.sleep(forTimeInterval: 0.6)
               }
           }
       }
       
       queue.addOperation(op)
       
       op.addExecutionBlock {
           autoreleasepool {
               for _ in 1..<100 {
                   guard !self.isCancelled else {return}
                   print("🍋", separator: " ", terminator: " ")
                   Thread.sleep(forTimeInterval: 0.5)
               }
           }
       }
       
       let op2 = CustomOperation(type: "🍩")
       queue.addOperation(op2)
       
       op.completionBlock = {
           print("Done")
       }
   }
   
   @IBAction func cancelOperation(_ sender: Any) {
       isCancelled = true
       queue.cancelAllOperations()
   }
   
    override func viewWillDisappear(_ animated: Bool) {
        self.cancelOperation("nil")
    }
   deinit {
      print(self, #function)
   }
}
