//
//  MainScreenView.swift
//  Weather
//
//  Created by Ксения Гагина on 27.07.2025.
//

import UIKit

protocol MainScreenViewInput {
  /// Показать местоположение пользователя
  func didUpdateUserLocation(latitude: Double, longitude: Double)
  /// Показать ошибку
  func showError(_ message: String)
  func updateWeather(with weatherData: WeatherDataModels)
  func configure(models: [Any])
}
protocol MainScreenViewOutput: AnyObject {}

final class MainScreenView: UIView {
  weak var output: MainScreenViewOutput?
  private let tableView = UITableView()
  private var models: [Any] = []
  private let gradientLayer = CAGradientLayer()
  override init (frame: CGRect) {
    super.init(frame: frame)
    initialize()
    setLayout()
    setupGradient()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
      super.layoutSubviews()
      gradientLayer.frame = bounds  // обновляем размер градиентного слоя под размеры view
    }
}


// MARK: - MainScreenViewInput

extension MainScreenView: MainScreenViewInput {
  func configure(models: [Any]) {
    self.models = models
    tableView.reloadData()
  }
  func updateWeather(with weatherData: WeatherDataModels) {}
  func didUpdateUserLocation(latitude: Double, longitude: Double) {
    print("Местоположение пользователя: \(latitude), \(longitude)")
  }
  func showError(_ message: String) {
    print("Ошибка: \(message)")
  }
}

// MARK: - MainScreenView

private extension MainScreenView {
  
  private func setupGradient() {
    gradientLayer.colors = [
      UIColor(red: 0x29/255, green: 0xB2/255, blue: 0xDD/255, alpha: 1).cgColor,
      UIColor(red: 0x33/255, green: 0xAA/255, blue: 0xDD/255, alpha: 1).cgColor,
      UIColor(red: 0x2D/255, green: 0xC8/255, blue: 0xEA/255, alpha: 1).cgColor,
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    layer.insertSublayer(gradientLayer, at: 0)
  }
  
  func setLayout() {
    [tableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
  
  func initialize() {
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 250
    tableView.backgroundColor = .clear
    tableView.register(WeatherHeaderCell.self, forCellReuseIdentifier: WeatherHeaderCell.reuseIdentifier)
  }
}

// MARK: - UITableViewDelegate

extension MainScreenView: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension MainScreenView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("models.count = \(models.count)")
    return models.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("Запрашиваем ячейку для строки: \(indexPath.row)")
    let model = models[indexPath.row]
    guard let headerModel = model as? WeatherHeaderCellModel else {
      return UITableViewCell()
    }
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: WeatherHeaderCell.reuseIdentifier,
      for: indexPath
    ) as? WeatherHeaderCell else {
      return UITableViewCell()
    }
    cell.configure(
      image: headerModel.icon,
      degrees: headerModel.temperature,
      description: headerModel.description
    )
    return cell
  }
}
