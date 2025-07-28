//
//  MainScreenView.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

protocol MainScreenViewInput{}
protocol MainScreenViewOutput: AnyObject {}

final class MainScreenView: UIView {
  
 weak var output: MainScreenViewOutput?
  
  override init (frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MainScreenView: MainScreenViewInput {
  
}
