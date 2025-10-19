//
//  MainScreenView.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

protocol MainScreenViewInput {
  /// Показать местоположение пользователя
  func didUpdateUserLocation(latitude: Double, longitude: Double)
  /// Показать ошибку
  func showError(_ message: String)
  func updateWeather(with weatherData: WeatherDataModels)
}
protocol MainScreenViewOutput: AnyObject {}

final class MainScreenView: UIView {
  weak var output: MainScreenViewOutput?
  override init (frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = .red
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MainScreenView: MainScreenViewInput {
  func updateWeather(with weatherData: WeatherDataModels) {
    print("Город: \(weatherData.city.name)")
      // Проходим по часам прогноза и выводим температуру и описание
      for hour in weatherData.list {
        print(
          "\(hour.dtTxt): Температура: \(hour.main.temp)°C, Описание: \(hour.weather.first?.description ?? "нет данных")"
        )
      }
  }
  
  func didUpdateUserLocation(latitude: Double, longitude: Double) {
    print("Местоположение пользователя: \(latitude), \(longitude)")
  }
  func showError(_ message: String) {
    print("Ошибка: \(message)")
  }
}
