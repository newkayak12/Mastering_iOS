
//: [Previous](@previous)

import Foundation

/*:
 # Date Calculation
 */

extension Date {
    init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, calendar: Calendar = .current) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.day = day
        
        guard let date = calendar.date(from: components) else {
            return nil
        }
        
        self = date
    }
}

let calendar = Calendar.current
let worldCup2002 = Date(year: 2002, month: 5, day: 31)!


let now = Date();
let today = calendar.startOfDay(for: now)

var comps = DateComponents()
comps.day = 100
comps.hour = 12//시간이 지나서 날짜가 변경될 수 있음

calendar.date(byAdding: comps, to: now)
calendar.date(byAdding: comps, to: today)


comps = calendar.dateComponents([.day], from: worldCup2002, to: today)
comps.day

//: [Next](@next)
