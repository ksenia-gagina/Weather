//
//  MainScreenViewFactory.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

protocol MainScreenViewFactoryInput {}
protocol MainScreenViewFactoryOutput: AnyObject {}

final class MainScreenViewFactory {
  weak var output: MainScreenViewFactoryOutput?
  
}
extension MainScreenViewFactory: MainScreenViewFactoryInput {
  
}
