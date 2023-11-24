//
//  GetWeather.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/20.
//

import Foundation

// キャッシュされた天気データ
struct CachedWeatherForecast: Codable {
    let city: String                      // 都市名
    let forecast: WeatherForecastResponse //天気データ
    let dateCached: Date                  //日付

    init(city: String, forecast: WeatherForecastResponse) {
        self.city = city
        self.forecast = forecast
        self.dateCached = Date() // 現在の日付と時刻を設定
    }
}

// 天気情報のキャッシュを管理
struct WeatherCacheManager {
    static let shared = WeatherCacheManager()
    private let defaults = UserDefaults.standard

    // キャッシュに天気情報を保存
    func cacheWeatherForecast(for city: String, forecast: WeatherForecastResponse) {
        let cacheData = CachedWeatherForecast(city: city, forecast: forecast)
        if let encoded = try? JSONEncoder().encode(cacheData) {
            defaults.set(encoded, forKey: city)
        }
    }

    // 指定した都市名のキャッシュされた天気を取得
    func getWeatherForecast(for city: String) -> WeatherForecastResponse? {
        if let cachedData = defaults.data(forKey: city),
           let cachedForecast = try? JSONDecoder().decode(CachedWeatherForecast.self, from: cachedData),
           Calendar.current.isDateInToday(cachedForecast.dateCached) {
            return cachedForecast.forecast
        }
        // 当日でないとき
        return nil
    }
}


class WeatherService {
    private let apiKey: String = "YOUR_API_KEY_HERE"
    private let cacheKey: String = "WeatherForecastCache"

    // APIデータの取得と使用
    func fetchWeatherForecast(city: String, completion: @escaping (WeatherForecastResponse?) -> Void) {
        // キャッシュの確認
        if let cachedForecast = WeatherCacheManager.shared.getWeatherForecast(for: city) {
            completion(cachedForecast)
            return
        }

        // URLセッションの設定
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric&lang=ja"

        // URLエンコーディング
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        print("URL: \(url)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Request error: \(error)")
                    completion(nil)
                    return
                }

                guard let data = data else {
                    completion(nil)
                    return
                }

                do {
                    let forecast = try JSONDecoder().decode(WeatherForecastResponse.self, from: data)
                    print("response: \(forecast)")
                    // 取得した情報はキャッシュ保存
                    WeatherCacheManager.shared.cacheWeatherForecast(for: city, forecast: forecast)
                    completion(forecast)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}
