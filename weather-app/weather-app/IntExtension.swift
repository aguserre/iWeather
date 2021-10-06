//
//  IntExtension.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//
import Foundation
extension Int {
    
    func convertToHourDay(timeFromGMT: Int) -> Int {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        var calendar = Calendar.current
        if let timeZone = TimeZone(secondsFromGMT: timeFromGMT) {
            calendar.timeZone = timeZone
        }
        
        let hour = calendar.component(.hour, from: date)

        return hour
    }

}
