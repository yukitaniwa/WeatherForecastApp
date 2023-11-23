//
//  DetailView.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/19.
//

import SwiftUI

struct DetailView: View {
    var title: String
    var forecast: WeatherForecastResponse?
    let prefixNum: Int = 7 // リストに表示する予報の日数
    
    var body: some View {
        List {
            if let forecast = forecast {
                ForEach(forecast.list.prefix(prefixNum), id: \.dt) { item in
                    if let iconCode = item.weather.first?.icon {
                        let iconURL = URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")
                        CustomCellView(forecastItem: item, iconURL: iconURL)
                    } else {
                        CustomCellView(forecastItem: item)
                    }
                }
            } else {
                Text("No data item")
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
    }
}

struct CustomCellView: View {
    var forecastItem: ForecastData
    var iconURL: URL?
    
    var body: some View {
        VStack {
            // 天気アイコンの表示
            if let iconURL = iconURL {
                AsyncImage(url: iconURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 50, height: 50)
            }
            // 日付の表示
            Text("Date: \(forecastItem.dtTxt)")
            // 平均気温の表示
            Text(String(format: NSLocalizedString("list_title_average_temperature", comment: ""), Int(forecastItem.main.temp.rounded())))
        }.padding()
    }
}
