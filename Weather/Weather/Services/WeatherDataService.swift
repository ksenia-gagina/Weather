//
//  WeatherDataService.swift
//  Weather
//
//  Created by Ксения Гагина on 19.10.2025.
//

import UIKit

protocol WeatherDataServiceProtocol {
  func getListWeatherData(completion: (([WeatherDataModels]) -> Void)?)
}

final class WeatherDataService: WeatherDataServiceProtocol {
  func getListWeatherData(completion: (([WeatherDataModels]) -> Void)?) {
    DispatchQueue.global().async {
      /// Базовый URL
      let baseURLString = "https://pro.openweathermap.org/data/2.5/forecast/hourly"
      /// URLComponents из базового URL
      guard var urlComponents = URLComponents(string: baseURLString) else {
        fatalError("Некорректный URL")
      }
      /// Добавляем query  параметры
      urlComponents.queryItems = [
        URLQueryItem(name: "lat", value: "55.75"),
        URLQueryItem(name: "lon", value: "37.61"),
        URLQueryItem(name: "appid", value: "898cee4330ca2805a4543bbf0acf4fa3"),
        URLQueryItem(name: "cnt", value: "96"),
        URLQueryItem(name: "units", value: "metric"),
        URLQueryItem(name: "lang", value: "ru")
      ]
      // Получаем итоговый URL
      guard let url = urlComponents.url else {
        fatalError("Не удалось создать URL с query параметрами")
      }
      // Создаем объект запроса
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      // Инициализируем URLSession
      let session = URLSession.shared
      // Создаем задачу для выполнения запроса
      let task = session.dataTask (with: request) { data,response,error in
        // Обработка ошибки
        if let error = error {
          print("Ошибка\(error.localizedDescription)")
          return
        }
        guard let data else {
          print("Данные не получены")
          return
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("Ответ сервера JSON:\n\(responseString ?? "пусто")")
        
        do {
          let apiResponce = try JSONDecoder().decode(WeatherDataDTO.self, from: data)
          print("Полученный объект:\(apiResponce)")
        } catch {
          print("Ошибка парсинга JSON:\(error)")
        }
      }
      task.resume()
    }
  }
}
