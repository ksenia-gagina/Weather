//
//  WeatherHeaderCell.swift
//  Weather
//
//  Created by Ксения Гагина on 08.11.2025.
//

import UIKit

public final class WeatherHeaderCell: UITableViewCell {
  public static let reuseIdentifier = WeatherHeaderCell.description()
  
  private let weatherImageViews = WeatherImageViews()
  private let degreesText = UILabel()
  private let descriptionText = UILabel()
  private let verticalStackView = UIStackView()
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    
  }
  
  public required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configure(
    image: UIImage?,
    degrees: String,
    description: String
  ) {
    weatherImageViews.setImage(image: image, style: .large)
    degreesText.text = degrees
    descriptionText.text = description
    
    setLayout()
    initialize()
  }
}


private extension WeatherHeaderCell {
  func setLayout() {
    [weatherImageViews, degreesText, descriptionText].forEach{
      $0.translatesAutoresizingMaskIntoConstraints = false
      verticalStackView.addArrangedSubview($0)
    }
    [verticalStackView].forEach{
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      verticalStackView.topAnchor.constraint(equalTo: topAnchor),
      verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
    ])
  }
  
  func initialize() {
    selectionStyle = .none
    backgroundColor = .white
    contentView.backgroundColor = .white
    
    verticalStackView.axis = .vertical
    verticalStackView.alignment = .center
    
    degreesText.numberOfLines = 0
    degreesText.font = .systemFont(ofSize: 64, weight: .bold)
    
    descriptionText.font = .systemFont(ofSize: 18, weight: .regular)
    descriptionText.numberOfLines = 0
    
    
  }
}


