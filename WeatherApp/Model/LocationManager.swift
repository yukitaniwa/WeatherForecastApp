//
//  LocationManager.swift
//  WeatherApp
//
//  Created by 谷輪侑樹 on 2023/11/30.
//

import CoreLocation

// 位置情報サービスの管理
// ユーザの位置情報を取得し、その位置情報をもとに都市名を逆ジオコーディングする機能を提供
class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    var location: CLLocation?
    var onLocationUpdated: ((CLLocation) -> Void)?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // 位置情報の使用許可をリクエストし、位置情報を取得する
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    // 位置情報が更新されたときに呼ばれるデリゲート
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            onLocationUpdated?(location)
        }
    }

    // 位置情報の取得に失敗したときに呼ばれるデリゲート
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }
    
    // 逆ジオコーディングを使用して位置情報から都市名を取得
    func getPrefectureName(from location: CLLocation, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error)")
                completion(nil)
                return
            }

            if let city = placemarks?.first?.administrativeArea {
                completion(city)
            } else {
                completion(nil)
            }
        }
    }
}

