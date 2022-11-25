import UIKit

/*:
 # Date Type and Reference Date
 
 ### Reference date: 2001-01-01 00:00:00 / UTC
 */


let now = Date()
print(now)

var dt = Date(timeIntervalSinceReferenceDate: 60 * 60)
print(dt)


//: [Next](@next)
