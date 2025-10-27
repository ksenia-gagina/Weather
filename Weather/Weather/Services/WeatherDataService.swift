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
            // Загружаем mock-данные
            guard let weatherModel = self.loadMockWeatherData() else {
                DispatchQueue.main.async {
                    completion?([])
                }
                return
            }
            // Возвращаем результат в main thread
            DispatchQueue.main.async {
                completion?([weatherModel])
            }
        }
    }
    func loadMockWeatherData() -> WeatherDataModels? {
        // 1. Получаем URL файла в бандле
        // Убедитесь, что имя "mockWeather" и расширение "json" совпадают с вашим файлом
        guard let url = Bundle.main.url(forResource: "mockWeather", withExtension: "json") else {
            print("❌ Ошибка: файл mockWeather.json не найден в проекте!")
            return nil
        }
        // 2. Загружаем данные из URL
        let data: Data
        do {
            data = try Data(contentsOf: url)
        } catch {
            print("❌ Ошибка: не удалось загрузить данные из \(url): \(error)")
            return nil
        }
        // 3. Декодируем JSON в наши Swift-структуры
        do {
            let decoder = JSONDecoder()
            let weatherResponse = try decoder.decode(WeatherDataDTO.self, from: data)
            return weatherResponse.mapTo()
        } catch {
            print("❌ Ошибка: не удалось декодировать JSON: \(error)")
            return nil
        }
    }
}
