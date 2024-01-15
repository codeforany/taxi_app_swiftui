//
//  BackgroundCleanerView.swift
//  taxi_driver
//
//  Created by CodeForAny on 10/10/23.
//

import SwiftUI

struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    BackgroundCleanerView()
}
