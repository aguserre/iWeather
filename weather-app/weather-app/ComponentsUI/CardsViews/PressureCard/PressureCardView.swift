//
//  PressureCardView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct PressureCardView: View {
    
    @ObservedObject private var viewModel: PressureCardViewModel
    
    init(viewModel: PressureCardViewModel) {
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
                
                VStack {
                    ProgressBarView(value: $viewModel.progressValue, width: viewModel.width - 10)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(Animation.linear(duration: 0.5)) {
                                    viewModel.progressValue = viewModel.currentProgress
                                }
                            }
                        }
                    
                    Text(viewModel.description)
                        .font(.system(size: 12, weight: .medium))
                }
                Spacer()
            }
        }.frame(width: viewModel.width, height: 100)
    }
}

struct PressureCardView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = PressureCardViewModel(title: "Pressure", imagetitle: "thermometer.sun", preassure: 1500, size: UIScreen.main.bounds.size)
        PressureCardView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}
