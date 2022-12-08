//
//  Date+Extension.swift
//  AppUIKit
//
//  Created by Ali Alaa on 08/12/2022.
//

import Foundation

public extension Date {
    static var today: Date { return Date().today }
    static var tomorrow:  Date { return Date().tomrrow }
    static var dayAfterTomorrow:  Date { return Date().dayAfterTomorrow }
    var today: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: noon)!
    }
    var tomrrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var dayAfterTomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomrrow.month != month
    }
}
