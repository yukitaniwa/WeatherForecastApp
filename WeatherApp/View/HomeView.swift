//
//  HomeView.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/18.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
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

              Button(LocalizedStringKey("button_tile_place"), action: {
                  // 位置情報を取得するロジックを追加
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
