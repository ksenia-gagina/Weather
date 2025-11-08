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
  func configure(models: [WeatherDataModels])
}
protocol MainScreenViewOutput: AnyObject {}

final class MainScreenView: UIView {
  
  weak var output: MainScreenViewOutput?
  
  private let tableView = UITableView()
  private var models: [WeatherDataModels] = []
  
  override init (frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .red
    
    initialize()
    setLayout()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
// MARK: - MainScreenViewInput

extension MainScreenView: MainScreenViewInput {
  func configure(models: [WeatherDataModels]) {
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
  func setLayout() {
    [tableView].forEach{
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
    backgroundColor = .clear
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.backgroundColor = .clear
    
    tableView.register(WeatherHeaderCell.self, forHeaderFooterViewReuseIdentifier: WeatherHeaderCell.reuseIdentifier)
                       }
}

// MARK: - UITableViewDelegate

extension MainScreenView: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension MainScreenView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Получаем модель данных
    let model = models[indexPath.row]
    
    // Приводим модель к твоему типу модели ячейки
    guard let headerModel = model as? WeatherHeaderCellModel else {
      return UITableViewCell()
    }
    
    // Декью ячейку правильного типа
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: WeatherHeaderCell.reuseIdentifier,
      for: indexPath
    ) as? WeatherHeaderCell else {
      return UITableViewCell()
    }
    
    // Конфигурируем ячейку с данными модели
    cell.configure(
      image: headerModel.icon,
      degrees: headerModel.temperature,
      description: headerModel.description
    )
    
    return cell
  }
}

