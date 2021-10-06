//
//  OffserPageTabView.swift
//  weather-app
//
//  Created by Agustin Errecalde on 06/10/2021.
//

import SwiftUI

struct OffsetPageTabView<Content: View>: UIViewRepresentable {
    
    var content: Content
    @Binding var offset: CGFloat
    
    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let hostView = UIHostingController(rootView: content)
        hostView.view.backgroundColor = .clear
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ]
        
        scrollView.addSubview(hostView.view)
        scrollView.addConstraints(constraints)
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: OffsetPageTabView
        
        init(parent: OffsetPageTabView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
    
}
