//
//  HomeView.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/18.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()

    // 入力されたテキスト
    @State private var selectedCity:String = ""
    @State private var isReadyToNavigate: Bool = false

    private let weatherService = WeatherService()

    var body: some View {
        NavigationView{
          VStack {
              List(prefectures) { prefecture in
                  Button(prefecture.title) {
                      // ボタンが押されたら、選択された都道府県を設定し、天気予報を取得
                      viewModel.fetchWeatherForecast(for: prefecture.query)
                      self.selectedCity = prefecture.title
                  }
              }

              // ボタン押下で位置情報取得
              Button(LocalizedStringKey("button_tile_place"), action: {
                  locationManager.requestLocation()
                  locationManager.onLocationUpdated = { location in
                      locationManager.getPrefectureName(from: location) { prefecture in
                          if let prefecture = prefecture, let romanizedPrefecture = prefectureRomanization[prefecture] {
                              viewModel.fetchWeatherForecast(for: romanizedPrefecture)
                              self.selectedCity = prefecture
                          }
                      }
                  }
              })
              .frame(minWidth: 0, maxWidth: .infinity)
              .padding()
              .background(Color.blue)
              .foregroundColor(.white)
              .cornerRadius(10)
              .padding(.horizontal, 16)

              // 予報データがある場合、DetailViewへのナビゲーションリンクを表示
              NavigationLink(destination: DetailView(title: selectedCity, forecast: viewModel.forecast), isActive: $viewModel.isReadyToNavigate) {
                  EmptyView()
              }
           }
          .navigationBarTitle(LocalizedStringKey("navigation_title_weather_forecast"))
        }
    }
}

#Preview {
    HomeView()
}
