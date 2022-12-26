import UIKit


class DispatchQueueViewController: UIViewController {
   
   @IBOutlet weak var valueLabel: UILabel!

    let serialWorkQueue = DispatchQueue(label: "SerialWorkQueue");
    let concurrentWorkQueue = DispatchQueue(label: "ConcurrnetWorkQueue", attributes: .concurrent)
   
   @IBAction func basicPattern(_ sender: Any) {
       //global == 시스템이 관리하는 background Queue
       DispatchQueue.global().async { //autoreleasepool을 자동으로 관리해줌(Dispatchqueue가)
           var total = 0
           for num in 1...100 {
              total += num
              Thread.sleep(forTimeInterval: 0.1)
               
               DispatchQueue.main.async {
                   self.valueLabel.text = "\(total)"
               }
           }
       }
   }
   
   @IBAction func sync(_ sender: Any) {
       concurrentWorkQueue.sync {
           for _ in 0..<3 {
               print("Hello")
           }
           print("Point 1")
       }
       print("Point 2")
   }
   
   @IBAction func async(_ sender: Any) {
       concurrentWorkQueue.async {
           for _ in 0..<3 {
               print("Hello")
           }
           print("Point 1")
       }
       print("Point 2")
   }
   
   @IBAction func delay(_ sender: Any) {
       let delay = DispatchTime.now() + 3;
       concurrentWorkQueue.asyncAfter(deadline: delay){
           print("Point 1")
       }
       print("Point 2")
   }
   
   @IBAction func concurrentIteration(_ sender: Any) {
       var start = DispatchTime.now()
       for index in 0..<20 {
           print(index, separator: " ", terminator: " ")
           Thread.sleep(forTimeInterval: 0.1)
       }
       var end = DispatchTime.now()
       
       print("\nfor-in : \(Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 100_000_000_0)")
       
       start = DispatchTime.now()
       DispatchQueue.concurrentPerform(iterations: 20) { index in
           print(index, separator: " ", terminator: " ")
           Thread.sleep(forTimeInterval: 0.1)
       }
       end = DispatchTime.now()
       print("\nconcurrentPerform : \(Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 100_000_000_0)")
   }
}
























