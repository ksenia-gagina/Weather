//
//  WeatherDataDTO.swift.swift
//  Weather
//
//  Created by Ксения Гагина on 19.10.2025.
//

import UIKit

struct WeatherDataDTO: Codable {
  let list: [HourForecastDTO]
  let city: CityDTO
}

// Ключи кодирования WeatherDataDTO
enum CodingKeysWeatherDataDTO: String, CodingKey {
  case list
  case city
}

struct HourForecastDTO: Codable {
  let dtTxt: String
  let main: MainDTO
  let weather: [WeatherDTO]
  let wind: WindDTO
  let pop: Double?
}

// Ключи кодирования HourForecastDTO
enum CodingKeysHourForecastDTO: String, CodingKey {
  case dtTxt = "dt_txt"
  case main
  case weather
  case wind
  case pop
}

struct MainDTO: Codable {
  let temp: Double
  let tempMin: Double
  let tempMax: Double
  let humidity: Int
}
// Ключи кодирования MainDTO
enum CodingKeysMainDTO: String, CodingKey {
  case temp
  case tempMin = "temp_min"
  case tempMax = "temp_max"
  case humidity
}

struct WeatherDTO: Codable {
  let description: String
  let icon: String
}

// Ключи кодирования WeatherDTO
enum CodingKeysWeatherDTO: String, CodingKey {
  case description
  case icon
}
  
struct WindDTO: Codable {
  let speed: Double
}

// Ключи кодирования WeatherDTO
enum CodingKeysWindDTO: String, CodingKey {
  case speed
}

struct CityDTO: Codable {
  let name: String
}

// Ключи кодирования WeatherDTO
enum CodingKeysCityDTO: String, CodingKey {
  case name
}

// MARK: - WeatherDataDTO

extension WeatherDataDTO {
  func mapTo() -> WeatherDataModels {
    WeatherDataModels(
      list: list.map{ $0.mapTo() },
      city: city.mapTo()
    )
  }
}

// MARK: - HourForecastDTO

extension HourForecastDTO {
  func mapTo() -> HourForecast {
    HourForecast(
      dtTxt: dtTxt,
      main: main.mapTo(),
      weather: weather.map { $0.mapTo() },
      wind: wind.mapTo(),
      pop: pop
    )
  }
}

// MARK: - MainDTO

extension MainDTO {
  func mapTo() -> Main {
    Main(
      temp: temp,
      tempMin: tempMin,
      tempMax: tempMax,
      humidity: humidity
    )
  }
}

// MARK: - WeatherDTO

extension WeatherDTO {
  func mapTo() -> Weather {
    Weather(
      description: description,
      icon: icon
    )
  }
}

// MARK: - WindDTO

extension WindDTO {
  func mapTo() -> Wind {
    Wind(
      speed: speed
    )
  }
}

// MARK: - CityDTO

extension CityDTO {
  func mapTo() -> City {
    City(
      name: name
    )
  }
}
