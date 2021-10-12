//
//  MapCardViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import MapKit

final class MapCardViewModel: ObservableObject {
    @Published var region: MKCoordinateRegion
    let title = "Location"
    private let zoomScale: Double = 0.018
    
    init(longitude: Double, latitude: Double) {
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                                    span: MKCoordinateSpan(latitudeDelta: zoomScale, longitudeDelta: zoomScale))
    }
}
