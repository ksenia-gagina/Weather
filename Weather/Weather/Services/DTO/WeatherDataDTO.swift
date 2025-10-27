//
//  WeatherDataDTO.swift.swift
//  Weather
//
//  Created by Ксения Гагина on 19.10.2025.
//

import UIKit

struct WeatherDataDTO: Codable {
  let location: LocationDTO
  let currentWeather: CurrentWeatherDTO
  let hourlyForecast: [HourWeatherConditionsDTO]
  let dailyForecast: [DayWeatherConditionsDTO]
  let alerts: [AlertDTO]?
}

// MARK: - Локация

struct LocationDTO: Codable {
  let city: String
  let country: String
  let latitude: Double
  let longitude: Double
  let timezone: String
}

// MARK: - Текущая погода

struct CurrentWeatherDTO: Codable {
  let lastUpdated: String?
  let temperature: Double
  let feelsLike: Double
  let description: String?
  let icon: String?
  let humidity: Int
  let pressure: Double
  let windSpeed: Double
  let windDirection: String?
  let uvIndex: Int
  let visibility: Double
  let sunrise: String?
  let sunset: String?
}

// MARK: - Почасовой прогноз

struct HourWeatherConditionsDTO: Codable {
  let time: String
  let isoTime: String
  let temperature: Double
  let icon: String?
  let pop: Int
}

// MARK: - Ежедневный прогноз

struct DayWeatherConditionsDTO: Codable {
  let date: String
  let weekday: String
  let tempHigh: Double
  let tempLow: Double
  let description: String?
  let icon: String?
  let pop: Int
}

// MARK: - Оповещения (Alerts)

struct AlertDTO: Codable {
  let id: String
  let title: String
  let severity: String
  let effective: String
  let expires: String
  let description: String
}

// MARK: - WeatherDataDTO

extension WeatherDataDTO {
  func mapTo() -> WeatherDataModels {
    WeatherDataModels(
      location: location.mapTo(),
      current: currentWeather.mapTo(),
      hourly: hourlyForecast.map { $0.mapTo() },
      daily: dailyForecast.map { $0.mapTo() },
      alerts: alerts?.map { $0.mapTo() }
    )
  }
}
// MARK: - LocationDTO

extension LocationDTO {
  func mapTo() -> LocationModels {
    LocationModels(
      city: city,
      country: country,
      latitude: latitude,
      longitude: longitude,
      timezone: timezone
    )
  }
}

// MARK: - CurrentWeatherDTO

extension CurrentWeatherDTO {
  func mapTo() -> CurrentModels {
    CurrentModels(
      lastUpdated: lastUpdated,
      temperature: temperature,
      feelsLike: feelsLike,
      description: description,
      icon: icon,
      humidity: humidity,
      pressure: pressure,
      windSpeed: windSpeed,
      windDirection: windDirection,
      uvIndex: uvIndex,
      visibility: visibility,
      sunrise: sunrise,
      sunset: sunset
    )
  }
}

// MARK: - HourWeatherConditionsDTO

extension HourWeatherConditionsDTO {
  func mapTo() -> HourForecastModels {
    HourForecastModels(
      time: time,
      isoTime: isoTime,
      temperature: temperature,
      icon: icon,
      pop: pop
    )
  }
}

// MARK: - DayWeatherConditionsDTO

extension DayWeatherConditionsDTO {
  func mapTo() -> DailyForecastModels {
    DailyForecastModels(
      date: date,
      weekday: weekday,
      tempHigh: tempHigh,
      tempLow: tempLow,
      description: description,
      icon: icon,
      pop: pop
    )
  }
}

// MARK: - AlertDTO

extension AlertDTO {
  func mapTo() -> AlertModels {
    AlertModels(
      id: id,
      title: title,
      severity: severity,
      effective: effective,
      expires: expires,
      description: description
    )
  }
}
