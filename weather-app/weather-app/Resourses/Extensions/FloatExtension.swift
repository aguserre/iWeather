//
//  FloatExtension.swift
//  weather-app
//
//  Created by Agustin Errecalde on 12/10/2021.
//

import SwiftUI

extension Float {
    func getValueFromPercentage(value: CGFloat) -> Float {
        (abs(self) * Float(abs(value))) / 100
    }
}
