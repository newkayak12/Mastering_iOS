import UIKit

class DispatchWorkItemViewController: UIViewController {
   
   let workQueue = DispatchQueue(label: "WorkQueue")
   var currentWorkItem: DispatchWorkItem!
   
   @IBAction func submitItem(_ sender: Any) {
       currentWorkItem = DispatchWorkItem(block: {
           for num in 0..<100 {
               guard !self.currentWorkItem.isCancelled else {return}
               print(num, separator: " ", terminator: " ")
               Thread.sleep(forTimeInterval: 0.1)
           }
       })
       
       workQueue.async(execute: currentWorkItem)
       
       currentWorkItem.notify(queue: workQueue) {
           print("Done")
       }
       
       let result = currentWorkItem.wait(timeout: .now() +  3) //동기 메소드 -> 메인에서 실행하면 문제가 생길 수 있음
       switch result {
           case .timedOut:
               print("TimedOut")
           case .success:
               print("success")
       }
   }
   
   @IBAction func cancelItem(_ sender: Any) {
       currentWorkItem.cancel()
   }
}
