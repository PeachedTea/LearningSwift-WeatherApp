//
//  ContentView.swift
//  WeatherTutorial
//
//  Created by Caden Fehr on 2024-05-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            // if the location is given, try to get the weather then display it
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                }
                else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                    print("Error getting weather: \(error)")
                                }
                        }
                }
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
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    ContentView()
}
