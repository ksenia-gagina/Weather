//
//  MainScreenViewFactory.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

protocol MainScreenViewFactoryInput {
  func createContent()
}
protocol MainScreenViewFactoryOutput: AnyObject {
  func didcreateContent(models: [Any])
}

final class MainScreenViewFactory {
  weak var output: MainScreenViewFactoryOutput?
}
extension MainScreenViewFactory: MainScreenViewFactoryInput {
  
  func createContent() {
    var models: [Any] = []
    
    models.append(
      WeatherHeaderCellModel(
        icon: ._02D,
        temperature: "8°",
        description: "Облачно с прояснениями"
      )
    )
    output?.didcreateContent(models: models)
    
  }
}
