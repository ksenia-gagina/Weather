//
//  WeatherDataModels.swift
//  Weather
//
//  Created by Ксения Гагина on 19.10.2025.
//

import UIKit

struct WeatherDataModels {
  let list: [HourForecast]
  let city: City
}
/// Прогноз на 1 час
struct HourForecast {
  let dtTxt: String
  let main: Main
  let weather: [Weather]
  let wind: Wind
  let pop: Double?
}
/// Основные показатели погоды (температура, давление и т.п.)
struct Main: Codable {
  let temp: Double
  let tempMin: Double
  let tempMax: Double
  let humidity: Int
}
/// Погодные условия
struct Weather: Codable {
  let description: String
  let icon: String
}
/// Информация о ветре
struct Wind: Codable {
  let speed: Double
}
/// Данные о местоположении
struct City: Codable {
  let name: String
}
