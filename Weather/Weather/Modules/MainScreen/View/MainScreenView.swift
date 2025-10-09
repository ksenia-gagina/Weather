//
//  MainScreenView.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit
import CoreLocation


protocol MainScreenViewInput {}
protocol MainScreenViewOutput: AnyObject {}

final class MainScreenView: UIView {
  weak var output: MainScreenViewOutput?
  
  
  private let locationManager = CLLocationManager()

  override init (frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .red
    startLocationManager()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MainScreenView: MainScreenViewInput {
func startLocationManager() {
  locationManager.requestWhenInUseAuthorization()
  if CLLocationManager.locationServicesEnabled() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.pausesLocationUpdatesAutomatically = false
    locationManager.startUpdatingLocation()
  }
  }
}

extension MainScreenView: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let lastLocation = locations.last {
      print("latitude: \(lastLocation.coordinate.latitude)")
      print("longitude: \(lastLocation.coordinate.longitude)")
    }
  }
}
