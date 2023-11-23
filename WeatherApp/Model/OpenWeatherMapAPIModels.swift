//
//  OpenWeatherMapAPIModels.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/23.
//

import Foundation

// 天気予報のレスポンスを表すモデル
struct WeatherForecastResponse: Codable {
    let cod: String           // ステータスコード
    let message: Int          // メッセージコードまたはステータス
    let cnt: Int              // データエントリーの数
    let list: [ForecastData]  // 予報データのリスト
}

// 予報データを表すモデル
struct ForecastData: Codable {
    let dt: Int               // タイムスタンプ
    let main: MainData        // 主要な天気情報
    let weather: [Weather]    // 天気の条件
    let clouds: Clouds        // 雲の状態
    let wind: Wind            // 風の情報
    let visibility: Int       // 可視性
    let pop: Double           // 降水確率
    let sys: Sys              // システム関連のデータ
    let dtTxt: String         // 日付と時間のテキスト

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"  // JSONキーとモデルのプロパティ名をマッピング
    }
}

// 主要な天気情報を表すモデル
struct MainData: Codable {
    let temp: Double          // 気温
    let feelsLike: Double     // 体感温度
    let tempMin: Double       // 最低気温
    let tempMax: Double       // 最高気温
    let pressure: Int         // 気圧
    let humidity: Int         // 湿度

    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// 天気の条件を表すモデル
struct Weather: Codable {
    let id: Int               // 天気のID
    let main: String          // 天気の主要カテゴリ
    let description: String   // 天気の説明
    let icon: String          // アイコンID
}

// 雲の状態を表すモデル
struct Clouds: Codable {
    let all: Int              // 雲の量
}

// 風の情報を表すモデル
struct Wind: Codable {
    let speed: Double         // 風速
    let deg: Int              // 風向
    let gust: Double          // 突風速度
}

// システム関連のデータを表すモデル
struct Sys: Codable {
    let pod: String           // 部分的な時間帯情報（昼/夜）
}

