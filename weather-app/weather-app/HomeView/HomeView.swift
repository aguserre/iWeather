//
//  HomeView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

import SwiftUI
import SpriteKit

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(viewModel.pageViewModels[viewModel.getIndex()].backgroundColor)
                .animation(.easeInOut, value: viewModel.getIndex())
                .edgesIgnoringSafeArea(.all)

            SceneSelectorView(condition: viewModel.pageViewModels[viewModel.getIndex()].weatherMainStatus)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            GeometryReader { proxy in
                VStack {
                    OffsetPageTabView(offset: $viewModel.offset) {
                        HStack(spacing: 0) {
                            ForEach(viewModel.pageViewModels, id: \.id) { viewModel in
                                WeatherPageView(viewModel: viewModel)
                                    .frame(width: proxy.size.width, height: proxy.size.height - 20)
                            }
                        }
                    }
                    HStack(spacing: 12) {
                        ForEach(viewModel.pageViewModels.indices, id: \.self) { index in
                            Capsule()
                                .fill(.white)
                                .frame(width: viewModel.getIndex() == index ? 20 : 7, height: 7)
                        }
                    }
                    .frame(height: 10)
                    .overlay(
                        Capsule()
                            .fill(.white)
                            .frame(width: 20, height: 7)
                            .offset(x: viewModel.getIndicatorOffset())
                        ,alignment: .leading
                    )
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .frame(height: proxy.size.height)
            }
        }
    }
}
