//
//  LocationManager.swift
//  CoreKit
//
//  Created by Ali Alaa on 07/12/2022.
//

import CoreLocation
import Combine

public final class LocationManager: NSObject {
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    
    private let errorMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    public var errorMessage: AnyPublisher<ErrorMessage, Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }
    
    private let userCurrentCitySubject = PassthroughSubject<String, Never>()
    public var userCurrentCity: AnyPublisher<String, Never> {
        userCurrentCitySubject.eraseToAnyPublisher()
    }
    
    // MARK: - Life cycle
    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: - Methods
    public func requestLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        DispatchQueue.global().async { [weak self] in
            if CLLocationManager.locationServicesEnabled() {
                self?.locationManager.startUpdatingLocation()
                self?.locationManager.requestAlwaysAuthorization()
            } else {
                self?.locationManager.startUpdatingLocation()
            }
        }
    }
    
    private func checkLocationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse:
            requestLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
    
}

// MARK: - Extension for location manager delegate
extension LocationManager: CLLocationManagerDelegate {
    
    // MARK: - delegate methods
    public func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let geocoder = CLGeocoder()
        
        guard let userLocation = userLocation else {
            errorMessageSubject.send(ErrorMessage(message: "Error occur in fetch your current location."))
            return
        }
        geocoder.reverseGeocodeLocation(userLocation) { [weak self] (placemarks, error) in
            guard let strongSelf = self, error == nil else {
                self?.errorMessageSubject.send(ErrorMessage(message: "Error occur in getting your current city."))
                return
            }
            if let firstLocation = placemarks?[0], let cityName = firstLocation.locality {
                strongSelf.userCurrentCitySubject.send(cityName)
                strongSelf.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: auth location error:  \(error.localizedDescription)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
