//
//  SmallCard.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct SmallCardView: View {
    
    private var viewModel: SmallCardViewModel
    
    init(viewModel: SmallCardViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            BlurView(style: .light)
                .frame(width: viewModel.width, height: 100)
                .cornerRadius(10)
            
            VStack {
                HStack {
                    Text(viewModel.title)
                        .padding(.top, 5)
                        .padding(.bottom, 1)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                    
                    Image(systemName: viewModel.imageTitle)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                
                Divider()
                    .frame(width: viewModel.width - 30, height: 1)
                    .background(Color.white)
                
                Spacer()
                
                Text(viewModel.description)
                    .padding(.top, 5)
                    .padding(.bottom, 1)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
            }
        }.frame(width: viewModel.width, height: 100)
    }
}
