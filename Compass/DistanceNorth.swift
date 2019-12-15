//
//  DistanceNorth.swift
//  Compass
//
//  Created by Pawel Kolano on 15/12/2019.
//  Copyright © 2019 Pawel Kolano. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class DistanceNorth: NSObject, ObservableObject, CLLocationManagerDelegate {
    var objectWillChange = PassthroughSubject<Void, Never>()
    var meterDistance: String = "" {
        didSet {
            objectWillChange.send()
        }
    }
    
    private let destination = CLLocation(latitude: 86.448, longitude: 175.346)
    
    private let locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        self.setup()
    }
    
    private func setup() {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.meterDistance = String(format: "%.4f", location.distance(from: destination)/1000)
        }
    }
}
