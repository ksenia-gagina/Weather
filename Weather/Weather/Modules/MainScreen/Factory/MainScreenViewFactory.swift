//
//  MainScreenViewFactory.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

protocol MainScreenViewFactoryInput {
  func createContent(from weatherData: WeatherDataModels)
}
protocol MainScreenViewFactoryOutput: AnyObject {
  func didcreateContent(models: [Any])
}

final class MainScreenViewFactory {
  weak var output: MainScreenViewFactoryOutput?
}
extension MainScreenViewFactory: MainScreenViewFactoryInput {
  func createContent(from weatherData: WeatherDataModels) {
    var models: [Any] = []
    models.append(
      WeatherHeaderCellModel(
        icon: UIImage(resource: ._02D),
        temperature: "\(Int(weatherData.current.temperature))°",
        description: weatherData.current.description ?? ""
      )
    )
    output?.didcreateContent(models: models)
  }
}
