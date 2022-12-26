import UIKit
class CustomOperation: Operation {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    override func main() {
        autoreleasepool {
            for _ in 1..<100 {
                guard !isCancelled else {return}
                print(type, separator: " ", terminator: " ")
                Thread.sleep(forTimeInterval: 0.9)
            }
        }
    }
}
































