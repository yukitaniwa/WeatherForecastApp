//
//  HomeView.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/18.
//

import SwiftUI

struct HomeView: View {
    // 入力されたテキスト
    @State private var selectedCity:String = ""
    @State private var isReadyToNavigate: Bool = false
    
    var body: some View {
        NavigationView{
          VStack {
              List(prefectures) { prefecture in
                  Button(prefecture.title) {
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
    
              // NavigationLink
           }
          .navigationBarTitle(LocalizedStringKey("navigation_title_weather_forecast"))
        }
    }
}

#Preview {
    HomeView()
}
