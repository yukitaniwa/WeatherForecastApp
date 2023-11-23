//
//  GetWeather.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/20.
//

import Foundation

class WeatherService {
    private let apiKey: String = "YOUR_API_KEY_HERE"
    
    // APIデータの取得と使用
    func fetchWeatherForecast(city: String, completion: @escaping (WeatherForecastResponse?) -> Void) {
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
                    completion(forecast)
                } catch {
                    print("JSON decoding error: \(error)")
                    completion(nil)
                }
            }
        }.resume()
    }
}
