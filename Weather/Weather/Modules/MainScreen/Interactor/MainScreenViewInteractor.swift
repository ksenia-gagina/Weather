//
//  MainScreenViewInteractor.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

protocol MainScreenViewInteractorInput {}
protocol MainScreenViewInteractorOutput: AnyObject {}

final class MainScreenViewInteractor {
  weak var output: MainScreenViewInteractorOutput?
}

extension MainScreenViewInteractor: MainScreenViewInteractorInput {
}
