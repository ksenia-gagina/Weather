//
//  MainScreenViewPresenter.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit
import CoreLocation

protocol MainScreenViewPresenterInput {}
protocol MainScreenViewPresenterOutput: AnyObject {}

final class MainScreenViewPresenter: UIViewController {

  weak var output: MainScreenViewPresenterOutput?
  let moduleView: UIView & MainScreenViewInput
  let factory: MainScreenViewFactoryInput
  let interactor: MainScreenViewInteractorInput

  // MARK: - Init

  init(
    moduleView: UIView & MainScreenViewInput,
    factory: MainScreenViewFactoryInput,
    interactor: MainScreenViewInteractorInput
  ) {
    self.moduleView = moduleView
    self.factory = factory
    self.interactor = interactor
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view = moduleView
    interactor.getUserLocation()
    interactor.getInfoWeather()
  }
}

// MARK: - MainScreenViewPresenterInput

extension MainScreenViewPresenter: MainScreenViewPresenterInput {
}

// MARK: - MainScreenViewFactoryOutput

extension MainScreenViewPresenter: MainScreenViewFactoryOutput {
}

// MARK: - MainScreenViewInteractorOutput

// Получает данные о местоположении и передает их во View для отображения пользователю или выводит сообщение об ошибке.
extension MainScreenViewPresenter: MainScreenViewInteractorOutput {
  func didUpdateWeather(_ weatherData: WeatherDataModels) {
    moduleView.updateWeather(with: weatherData)
  }

  func didUpdateUserLocation(_ location: CLLocation) {
    moduleView.didUpdateUserLocation(
      latitude: location.coordinate.latitude,
      longitude: location.coordinate.longitude
    )
  }
  func didFailWithError(with error: Error) {
    moduleView.showError(error.localizedDescription)
  }
}

// MARK: - MainScreenViewOutput

extension MainScreenViewPresenter: MainScreenViewOutput {
}
