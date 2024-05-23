//
//  WeatherView.swift
//  WeatherTutorial
//
//  Created by Caden Fehr on 2024-05-20.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Add the gradient background
            LinearGradient(gradient: Gradient(colors: [.black, .gray]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    // display city name
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(spacing: 20) {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                                
                                Text(weather.weather[0].main)
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text(weather.main.temp.roundDouble() + "°")
                                    .font(.system(size: 100))
                                    .fontWeight(.bold)
                                    .padding()
                                
                                Text("Feels like: \(weather.main.feelsLike.roundDouble())°")
                                    .font(.system(size: 20))
                                    .fontWeight(.light)
                                    .padding(.trailing)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 80)
                        
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        
        
        .edgesIgnoringSafeArea(.bottom)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}


