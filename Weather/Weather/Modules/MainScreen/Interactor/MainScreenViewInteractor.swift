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
  /// Вернули местоположение пользователя
  func didUpdateUserLocation(_ location: CLLocation)
  /// вернули ошибку
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

// MARK: - MainScreenViewInteractorInput

extension MainScreenViewInteractor: MainScreenViewInteractorInput {
  func getUserLocation() {
    switch locationManager.authorizationStatus {
      /// впервые просим разрешение,  запускаем запрос на доступ
    case.notDetermined:
      locationManager.requestWhenInUseAuthorization()
      /// доступ запрещен/ограничен, отправляем ошибку
    case .denied, .restricted:
      let err = NSError(domain: "Location", code: 0, userInfo: nil)
      output?.didFailWithError(with: err)
    case .authorizedAlways, .authorizedWhenInUse:
      /// разрешение есть, запуск обновления местоположения
      locationManager.startUpdatingLocation()
    @unknown default:
      break
    }
  }
}

extension MainScreenViewInteractor: CLLocationManagerDelegate {
  /// автоматически запускать запрос на локацию
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    getUserLocation()
  }
  /// обновление местоположения
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    output?.didUpdateUserLocation(location)
    locationManager.stopUpdatingLocation()
  }
  /// вызывается при ошибке получения местоположения
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    output?.didFailWithError(with: error)
  }
}
