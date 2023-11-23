//
//  Utils.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/23.
//

import Foundation

class Utils {
    // 日付フォーマット変更
    static func formatDtTxtToMMDD(_ dtTxt: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = inputFormatter.date(from: dtTxt) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MM/dd"
            return outputFormatter.string(from: date)
        } else {
            print("Invalid date format")
            return ""
        }
    }
}
