//
//  weather_appApp.swift
//  weather-app
//
//  Created by Agustin Errecalde on 05/10/2021.
//

import SwiftUI
import Combine

@main
struct weather_appApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State var cancellationToken: AnyCancellable?
    @State private var cancelable = Set<AnyCancellable>()
    private let service = WeatherService()
    
    @State var finishDownloadData: Bool = false
    @State var pageViewModels: [WeatherPageViewModel] = []
    let savedIds = ["2643743", "3441575", "3433955"]
    
    var body: some View {
        VStack {
            if finishDownloadData {
                HomeView(viewModel: HomeViewModel(pageViewModels: pageViewModels))
            } else {
                EmptyView()
            }
        }.onAppear {
            fetch(n: savedIds.count - 1)
        }
    }
    
    func fetch(n: Int) {
        let publishers = savedIds.map { id in
            self.service.fetch(byId: id)
        }
        Publishers.Sequence(sequence: publishers)
            .flatMap { $0 }
            .map { WeatherPageViewModel(weather: $0) }
            .collect()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print(error.localizedDescription)//TODO: Manage error
                case .finished: print("Success Download")
                }
            }, receiveValue: { val in
                self.pageViewModels = val
                self.finishDownloadData = true
            })
            .store(in: &cancelable)
    }

}

