//
//  MainScreenViewAssembly.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

final class MainScreenViewAssembly {
  func createModule() -> UIViewController & MainScreenViewPresenterInput {
    let factory = MainScreenViewFactory()
    let interactor = MainScreenViewInteractor()
    let view = MainScreenView()
    let presenter = MainScreenViewPresenter(moduleView: view, factory: factory, interactor: interactor)
    factory.output = presenter
    interactor.output = presenter
    view.output = presenter
    return presenter
  }
}
