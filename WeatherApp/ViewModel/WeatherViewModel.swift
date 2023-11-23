//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/25.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    // ビューに表示するデータを保持
    @Published var forecast: WeatherForecastResponse?
    @Published var isReadyToNavigate: Bool = false
    
    // WeatherServiceのインスタンス
    private let weatherService = WeatherService()

    // 天気予報を取得するメソッド
    func fetchWeatherForecast(for city: String) {
        weatherService.fetchWeatherForecast(city: city) { [weak self] forecast in
            DispatchQueue.main.async {
                // 天気予報データ更新
                self?.forecast = forecast
                self?.isReadyToNavigate = true
            }
        }
    }
}
