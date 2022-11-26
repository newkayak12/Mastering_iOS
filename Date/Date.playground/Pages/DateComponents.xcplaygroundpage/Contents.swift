
//: [Previous](@previous)

import Foundation

/*:
 # DateComponents
 */

let now = Date()
let calendar = Calendar.current

let components = calendar.dateComponents([.year, .month, .day], from: now)
components.year
components.month
components.day

let year = calendar.component(.year, from: now)

var memorialDayComponents = DateComponents();
memorialDayComponents.year = 2002
memorialDayComponents.month = 7
memorialDayComponents.day = 16

let memorialDay = calendar.date(from: memorialDayComponents)


//: [Next](@next)
