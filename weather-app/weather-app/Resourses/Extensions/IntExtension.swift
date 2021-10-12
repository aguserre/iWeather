//
//  IntExtension.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//
import SwiftUI

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
    
    func convertToCurrentTime(timeFromGMT: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        var calendar = Calendar.current
        if let timeZone = TimeZone(secondsFromGMT: timeFromGMT) {
            calendar.timeZone = timeZone
        }
        
        let hour = calendar.component(.hour, from: date)
        let mins = calendar.component(.minute, from: date)

        return formateNumberTime(val: hour)+" : "+formateNumberTime(val: mins)
    }
    
    func convertToPercentage(maxValue: CGFloat) -> Float {
        guard maxValue != 0 else { return 0 }
        return Float(abs(self) * 100) / Float(abs(maxValue))
    }
    
    private func formateNumberTime(val: Int) -> String {
        let valStr = String(val)
        return valStr.count == 1 ? "0"+valStr : valStr
    }

}
