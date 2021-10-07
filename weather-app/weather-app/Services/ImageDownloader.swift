//
//  ImageDownloader.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import Combine
import SwiftUI

final class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString: String) {
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(urlString).png") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
