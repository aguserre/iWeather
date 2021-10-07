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
            Color(viewModel.weathers[viewModel.getIndex()].backGroundColor)
                .animation(.easeInOut, value: viewModel.getIndex())
                .edgesIgnoringSafeArea(.all)
            
            SceneSelectorView(condition: viewModel.weathers[viewModel.getIndex()].weather.main)
                
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
                        ForEach(viewModel.weathers.indices, id: \.self) { index in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = HomeViewModel()
        HomeView(viewModel: vm)
    }
}
