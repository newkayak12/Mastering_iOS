
//: [Previous](@previous)

import Foundation

/*:
 # TimeInterval
*/

let oneSec = TimeInterval(1)
print(oneSec)
let oneMilliSec = TimeInterval(0.001)
let oneMin = TimeInterval(60)
let oneHour = TimeInterval(60 * 60)
let oneDay = TimeInterval(oneHour * 24)
Date(timeIntervalSinceNow: oneDay)
Date() //Now
//Date(timeIntervalSinceReferenceDate: ) //2001-01-01 기준
//Date(timeIntervalSince1970: ) // epoch
//Date(timeInterval: <#T##TimeInterval#>, since: <#T##Date#>) //custom
//: [Next](@next)
