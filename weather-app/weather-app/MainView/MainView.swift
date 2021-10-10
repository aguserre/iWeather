//
//  MainView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 09/10/2021.
//

import SwiftUI
import Combine

struct MainView: View {

    @ObservedObject private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            if viewModel.resultStatus == .finished {
                HomeView(viewModel: HomeViewModel(pageViewModels: viewModel.pageViewModels))
            } else {
                HomeView(viewModel: WeatherModel.placeHolder)
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(viewModel.errorMessage),
                            dismissButton: .default(Text(viewModel.alertButtonTitle), action: {
                                viewModel.alertButtonTapped()
                            })
                        )
                    }
            }
            if viewModel.isLoading {
                LoadingOverlaySUI()
                    .edgesIgnoringSafeArea(.all)
            }
        }.onAppear {
            viewModel.fetch()
        }
    }
    

}

