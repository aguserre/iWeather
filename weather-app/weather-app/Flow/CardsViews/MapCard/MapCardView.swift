//
//  MapCardView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 07/10/2021.
//

import SwiftUI
import MapKit


struct MapCardView: View {
    
    @ObservedObject private var viewModel: MapCardViewModel
    
    init(viewModel: MapCardViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            BlurView(style: .light)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                .cornerRadius(10)
            
            VStack {
                HStack {
                    Text(viewModel.title)
                        .padding(.top, 5)
                        .padding(.bottom, 1)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    
                    Image(systemName: "map")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                
                Divider()
                    .frame(width: (UIScreen.main.bounds.width * 0.8) - 30, height: 1)
                    .background(Color.white)
                
                Spacer()
                
                Map(coordinateRegion: $viewModel.region)
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 160)

            }.frame(width: UIScreen.main.bounds.width * 0.9)
            
        }.frame(width: UIScreen.main.bounds.width, height: 200)
    }
}

struct MapCardView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = MapCardViewModel(longitude: -60.49060549476346, latitude: -35.117716785493364)
        MapCardView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
