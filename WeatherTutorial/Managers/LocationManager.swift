//
//  LocationManager.swift
//  WeatherTutorial
//
//  Created by Caden Fehr on 2024-05-15.
//

import Foundation
import CoreLocation // Apples location framework

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // constants
    let manager = CLLocationManager()
    
    // variables
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // Function that requests the users location
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    // Function to check if the location was updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // set location var to array of location
        location = locations.first?.coordinate
        isLoading = false
    }
    
    // function to check if the location request threw an error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
