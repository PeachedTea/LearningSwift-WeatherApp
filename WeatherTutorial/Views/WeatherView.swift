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
            // Add a gradient to the background
            LinearGradient(gradient: getGradient(),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    // display city name
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    // display the date and time
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
                            
                            // Display the 'real' and 'feels like' temperature
                            
                            VStack(alignment: .trailing) {
                                Text(weather.main.temp.roundDouble() + "°")
                                    .font(.system(size: 100))
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Text("Feels like: ")
                                    Text("\(weather.main.feelsLike.roundDouble())°")
                                        .fontWeight(.bold)
                                }
                                .font(.system(size: 20))
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
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }
    
    private func getGradient() -> Gradient {
        let currentHour = Calendar.current.component(.hour, from: Date())
        // set a 'morning' gradient between 4 and 10
        if currentHour >= 4 && currentHour < 10 {
            return Gradient(colors: [.black, .orange])
            
        // set a 'evening' gradient between 18 and 24
        } else if currentHour >= 18 && currentHour < 24 {
            return Gradient(colors: [.black, .purple])
            
        // Default 'black and gray' gradient otherwise
        } else {
            return Gradient(colors: [.black, .gray])
        }
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
