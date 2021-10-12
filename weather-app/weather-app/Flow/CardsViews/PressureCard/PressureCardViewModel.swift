//
//  PressureCardViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

final class PressureCardViewModel: ObservableObject {
    private let spacing: CGFloat = 20
    private let maxPressure: CGFloat = 1500
    let currentProgress: Float

    @Published var width: CGFloat
    @Published var title: String
    @Published var imageTitle: String
    @Published var description: String
    @Published var progressValue: Float = 0
    
    init(title: String, imagetitle: String, preassure: Int, size: CGSize) {
        self.title = title
        self.imageTitle = imagetitle
        self.description = "\(preassure) hPa"
        self.width = size.width/2 - spacing
        
        let progressPercent = preassure.convertToPercentage(maxValue: maxPressure)
        currentProgress =  progressPercent.getValueFromPercentage(value: (size.width/2 - spacing))
    }
}
