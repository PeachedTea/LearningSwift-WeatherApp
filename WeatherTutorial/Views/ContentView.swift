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
            
            // if the location is given, display it
            if let location = locationManager.location {
                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
            }
            else {
                if locationManager.isLoading {
                    LoadingView()
                }
                else {
                }
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
        .background(.black)
        .preferredColorScheme(.dark)
        .padding()
    }
}

#Preview {
    ContentView()
}
