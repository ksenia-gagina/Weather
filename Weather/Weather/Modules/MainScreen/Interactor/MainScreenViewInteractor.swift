//
//  MainScreenViewInteractor.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import Foundation
import CoreLocation

protocol MainScreenViewInteractorInput {
  /// Получить разрешение на отслеживание местонахождения пользователя
  func getUserLocation()
}
protocol MainScreenViewInteractorOutput: AnyObject {
  func didUpdateUserLocation(_ location: CLLocation)
  func didFailWithError(with error: Error)
  
}

final class MainScreenViewInteractor: NSObject {
  weak var output: MainScreenViewInteractorOutput?
  private let locationManager = CLLocationManager()
  
  override init() {
     super.init()
     locationManager.delegate = self
     locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
     locationManager.pausesLocationUpdatesAutomatically = true
   }
}

extension MainScreenViewInteractor: MainScreenViewInteractorInput {
  func getUserLocation() {
    switch locationManager.authorizationStatus {
      /// впервые просим разрешение
    case.notDetermined:
      locationManager.requestWhenInUseAuthorization()
      /// сообщаем об отсутсвии доступа
    case .denied, .restricted:
      let err = NSError(domain: "Location", code: 0, userInfo: nil)
      output?.didFailWithError(with: err)
    case .authorizedAlways, .authorizedWhenInUse:
      /// разрешение есть, запуск обновлений
      locationManager.startUpdatingLocation()
    @unknown default:
      break
    }
  }
}

extension MainScreenViewInteractor: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    output?.didUpdateUserLocation(location)
    locationManager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
  }
}
