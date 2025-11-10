//
//  WeatherImageViews.swift
//  Weather
//
//  Created by Ксения Гагина on 08.11.2025.
//

import UIKit

public final class WeatherImageViews: UIView {
  private let imageView = UIImageView()
  public func setImage(image: UIImage?, style: WeatherImageViews.Style) {
    imageView.image = image
    setLayout(style: style)
  }
}

private extension WeatherImageViews {
  func setLayout(style: WeatherImageViews.Style) {
    [imageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
}

public extension WeatherImageViews {
  enum Style {
    case small
    case middle
    case large
    public var size: CGFloat {
      switch self {
      case .small:
        return 24
      case .middle:
        return 50
      case .large:
        return 250
      }
    }
  }
}
