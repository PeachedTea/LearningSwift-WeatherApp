//
//  ContentView.swift
//  WeatherTutorial
//
//  Created by Caden Fehr on 2024-05-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        VStack {
            WelcomeView()
                .environmentObject(locationManager)
        }
        .background(.black)
        .preferredColorScheme(.dark)
        .padding()
    }
}

#Preview {
    ContentView()
}
