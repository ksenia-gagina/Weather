//
//  WeatherDataModels.swift
//  Weather
//
//  Created by Ксения Гагина on 19.10.2025.
//

import UIKit

struct WeatherDataModels {
    let location: LocationModels
    let current: CurrentModels
    let hourly: [HourForecastModels]
    let daily: [DailyForecastModels]
    let alerts: [AlertModels]?
}

struct LocationModels {
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
    let timezone: String
}

struct CurrentModels {
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

struct HourForecastModels {
    let time: String
    let isoTime: String
    let temperature: Double
    let icon: String?
    let pop: Int
}

struct DailyForecastModels {
    let date: String
    let weekday: String
    let tempHigh: Double
    let tempLow: Double
    let description: String?
    let icon: String?
    let pop: Int
}

struct AlertModels {
    let id: String
    let title: String
    let severity: String
    let effective: String
    let expires: String
    let description: String
}
