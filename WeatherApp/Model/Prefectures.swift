//
//  Prefectures.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/23.
//

import Foundation

struct Prefecture: Identifiable {
    var id: Int
    let title: String
    let query: String
}

let prefectures: [Prefecture] = [
    Prefecture(id: 0, title: "北海道", query: "Hokkaido"),
    Prefecture(id: 1, title: "東京都", query: "Tokyo"),
    Prefecture(id: 2, title: "兵庫県", query: "Hyogo"),
    Prefecture(id: 3, title: "大分県", query: "Oita"),
]
