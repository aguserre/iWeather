//
//  TempCardView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct TempCardView: View {
    
    private var viewModel: TempCardViewModel
    
    init(viewModel: TempCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Text(viewModel.cityName)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            ZStack {
                Text(viewModel.currentTemp)
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(Color(UIColor.systemIndigo))
                
                Circle()
                    .strokeBorder(Color(UIColor.systemIndigo), lineWidth: 5, antialiased: true)
                    .frame(width: 18, height: 18)
                    .offset(x: viewModel.spaces, y: -15)
            }
            Text(viewModel.weatherDescription)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.white)
            
            HStack {
                Text(viewModel.minTemp)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                
                Text(viewModel.maxTemp)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
    }
}
