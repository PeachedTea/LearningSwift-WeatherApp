//
//  WeatherManager.swift
//  WeatherTutorial
//
//  Created by Caden Fehr on 2024-05-19.
//

import Foundation
import CoreLocation

/*
 WeatherManager
 @return: ResponseBody
 
 This class manages the requests and returns from the OpenWeather API and decodes it
 into and returns a ResponseBody structure which stores the data
 */
class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        
        // url for the API call
        guard let APIKey = Secrets.parse(jsonFile: "secrets") else {
            fatalError("Could not get API Key")}
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIKey.OpenWeatherAPIKey)&units=metric") else {fatalError("Missing URL")}
        
        // request the data from the url
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard ( response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error fetching weather data")}
        
        // decode the JSON data into a ResponseBody structure
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        // return the ResponseBody structure with data from the API call
        return decodedData
    }
    
}

// structure used to store the JSON information sent from an API call to OpenWeather
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
        
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double {return feels_like}
    var tempMin: Double {return temp_min}
    var tempMax: Double {return temp_max}
}

struct Secrets: Decodable {
    let OpenWeatherAPIKey: String
}

extension Decodable {
    static func parse(jsonFile: String) -> Secrets? {
        
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let APIKey = try? JSONDecoder().decode(Secrets.self, from: data)
            else {
            return nil
        }
        return APIKey
    }
}
