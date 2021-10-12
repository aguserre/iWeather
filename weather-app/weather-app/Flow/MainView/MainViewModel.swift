//
//  MainViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 09/10/2021.
//

import SwiftUI
import CoreLocation
import Combine

final class MainViewModel: NSObject, ObservableObject {
    private let service: WeatherProvider
    private let savedIds: [String]
    private let maxIntents: Int
    private var locationManager: CLLocationManager?
    private var publishers: [AnyPublisher<WeatherModel, Error>]
    
    @Published private var coordinates: CLLocationCoordinate2D?
    @Published private var cancellable: Set<AnyCancellable>
    
    @Published var resultStatus: ResultStatus
    @Published var weatherViewModel: WeatherViewModel
    @Published var errorMessage: String
    @Published var showAlert: Bool
    @Published var isLoading: Bool
    @Published var errorType: ErrorTypes
    @Published var retrysCount: Int
    
    override init() {
        service = WeatherProvider(apiClient: ApiClient())
        savedIds = WeatherModel.citySavedIds
        retrysCount = 0
        maxIntents = 3
        publishers = [AnyPublisher<WeatherModel, Error>]()
        cancellable = Set<AnyCancellable>()
        resultStatus = .none
        weatherViewModel = WeatherModel.placeHolder
        errorMessage = ""
        showAlert = false
        isLoading = true
        errorType = .none
        
        super.init()
        setupLocationManager()
    }
    
    enum ErrorTypes {
        case location, service, other, none
    }
    
    var alertButtonTitle: String {
        errorType != .service ? "Ok" : ( maxIntents <= retrysCount ? "Ok" : "Retry")
    }
    
    enum ResultStatus {
        case finished, none
    }
    
    func alertButtonTapped() {
        switch errorType {
        case .location:
            isLoading = true
            getWeathers()
        case .service:
            isLoading = true
            retryIfNeeded()
        case .other, .none:
            isLoading = false
            resultStatus = .none
        }
    }
    
    private func retryIfNeeded() {
        resultStatus = .none
        retrysCount += 1
        retrysCount <= maxIntents ? getWeathers() : setupAfterNetworkingFailed()
    }
    
    private func setupAfterNetworkingFailed() {
        isLoading = false
        resultStatus = .none
    }
    
    private func setupWithErrorResponse(_ error: Error) {
        errorType = (400...499).contains((error as NSError).code) ? .service : .other
        errorMessage = errorType == .service ? error.localizedDescription : CustomError.unexpected.rawValue
        resultStatus = .none
        isLoading = false
        
        showAlert = true
    }
    
    private func setupWithErrorLocation() {
        errorType = .location
        coordinates = nil
        
        showAlert = true
    }
    
}

//Service call
extension MainViewModel {
    private func getWeathers() {
        if !publishers.isEmpty { publishers.removeAll() }

        fillPublishers {
            Publishers.Sequence(sequence: self.publishers)
                .compactMap { $0 }
                .flatMap { $0 }
                .map { WeatherPageViewModel(weather: $0) }
                .collect()
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .failure(let error):
                        self.setupWithErrorResponse(error)
                    case .finished:
                        self.isLoading = false
                        self.resultStatus = .finished
                        self.errorType = .none
                    }
                }, receiveValue: { [weak self] pageViewModels in
                    guard let self = self else { return }
                    let sortedPages = pageViewModels.sorted(by: { $0.isCurrentWeather && !$1.isCurrentWeather })
                    self.weatherViewModel = WeatherViewModel(pageViewModels: sortedPages)
                })
                .store(in: &self.cancellable)
        }
    }
    
    private func fillPublishers(completion: @escaping ()->(Void)) {
        savedIds.forEach { id in
            publishers.append(service.allWeathersById(id: id))
        }
        
        if let location = coordinates {
            publishers.append(service.allWeathersByCoords(lon: location.longitude, lat: location.latitude))
        }
        completion()
    }
}

//Location Manager
extension MainViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        isLoading = true
        resultStatus = .none
        checkPermissions()
    }
    
    private func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
    }
    
    private func checkPermissions() {
        guard let locationManager = locationManager else {
            getWeathers()
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            errorMessage = CustomError.restricted.rawValue
            setupWithErrorLocation()
        case .denied:
            errorMessage = CustomError.denied.rawValue
            setupWithErrorLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            guard let coordinates = locationManager.location?.coordinate else { return }
            self.coordinates = coordinates
            getWeathers()
        @unknown default:
            getWeathers()
        }
    }
}
