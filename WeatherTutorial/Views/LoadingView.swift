//
//  LoadingView.swift
//  WeatherTutorial
//
//  Created by Caden Fehr on 2024-05-19.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
        .progressViewStyle(CircularProgressViewStyle(tint: .orange))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LoadingView()
}
