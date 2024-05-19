//
//  WeatherManager.swift
//  WeatherTutorial
//
//  Created by Caden Fehr on 2024-05-19.
//

import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocation, longitude: CLLocation) async throws {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=2d48206ea5bde563a613a90b474b8dc7&unitsmetric") else {fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard ( response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}

        
    }
    
}
