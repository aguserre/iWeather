//
//  SmalCardViewModel.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

final class SmallCardViewModel: ObservableObject {
    private let spacing: CGFloat = 25
    @Published var title: String
    @Published var imageTitle: String
    @Published var description: String
    @Published var width: CGFloat
    
    init(title: String, imagetitle: String, description: String, size: CGSize) {
        self.title = title
        self.imageTitle = imagetitle
        self.description = description
        self.width = size.width/2 - spacing
    }
    
}
