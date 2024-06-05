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
            BackgroundView()
            
            VStack {
                LocationDateView(weather: weather)
                
                // Sunrise and Sunset Info
                SunriseSunsetInfoView(weather: weather)
                
                Spacer()
                
                WeatherInfoView(weather: weather)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea(.all)
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}

private func getIcon(weather: ResponseBody) -> String {
    // Variable used to set the weatherIcon
    var weatherIcon = "exclamationmark.triangle.fill"
    
    switch weather.weather[0].main {
    case "Clear":
        weatherIcon = "sun.max"
    case "Rain":
        weatherIcon = "cloud.rain"
    case "Drizzle":
        weatherIcon = "cloud.drizzle"
    case "Thunderstorm":
        weatherIcon = "cloud.bolt.rain"
    case "Snow":
        weatherIcon = "cloud.snow"
    case "Clouds":
        weatherIcon = "cloud"
    case "Fog":
        weatherIcon = "cloud.fog"
    case "Smoke":
        weatherIcon = "smoke"
    case "Mist":
        weatherIcon = "humidity"
    default:
        weatherIcon = "exclamationmark.triangle.fill"
    }
    
    // return the icon to use
    return weatherIcon
}

// function to convert unix time to 24hr time
private func getTimeFromUnix(weather: ResponseBody, unix: Double) -> String {
    let time = NSDate(timeIntervalSince1970: unix)
    
    let dateFormat = DateFormatter()
    let timezone = weather.timezone
    dateFormat.timeZone = TimeZone(secondsFromGMT: timezone)
    dateFormat.dateFormat = "HH:mm"
    let formattedTime = dateFormat.string(from: time as Date)
    return formattedTime
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

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: getGradient(),
                       startPoint: .top,
                       endPoint: .bottom)
    }
}

struct WeatherInfoView: View {
    var weather: ResponseBody
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 20) {
                    // set the weatherIcon depending on conditions
                    Image(systemName: getIcon(weather: weather))
                        .font(.system(size: 40))
                        .padding(.top)
                    Text(weather.weather[0].main)
                    Text(weather.weather[0].description)
                        .italic()
                        .bold()
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
}

struct LocationDateView: View {
    var weather: ResponseBody
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // display city name
            Text(weather.name)
                .bold()
                .font(.title)
                .padding(.top, 32)
            // display the date and time
            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .fontWeight(.light)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SunriseSunsetInfoView: View {
    var weather: ResponseBody
    var body: some View {
        HStack {
            Image(systemName: "sun.horizon")
                .font(.system(size: 30))
            Text("\(getTimeFromUnix(weather: weather, unix: weather.sys.sunRise)) - \(getTimeFromUnix(weather: weather, unix: weather.sys.sunSet))")
                .padding(.top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
