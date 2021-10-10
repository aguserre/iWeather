//
//  ImageDownloader.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import Combine
import SwiftUI

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }
            
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(type: UrlType,
         loading: Image = Image(systemName: "rays"),
         failure: Image = Image(systemName: "rays")) {
        var urlComplete = ""
        switch type {
        case .icon(let iconId):
            urlComplete = "http://openweathermap.org/img/wn/\(iconId).png"
        case .url(let urlString):
            urlComplete = urlString
        }
        _loader = StateObject(wrappedValue: Loader(url: urlComplete))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

extension RemoteImage {
    enum UrlType {
        case icon(iconId: String)
        case url(urlString: String)
    }
}
