
//: [Previous](@previous)

import Foundation

/*:
 # TimeZone
 */

let calendar = Calendar.current
var components = DateComponents()
components.year = 2014
components.month = 4
components.day = 16
components.timeZone = TimeZone(identifier: "Asia/Seoul")
calendar.date(from: components)

components.timeZone = TimeZone(identifier: "America/Los_Angeles")
calendar.date(from: components)


for name in TimeZone.knownTimeZoneIdentifiers {
    print(name)
}






//: [Next](@next)
