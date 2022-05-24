//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import UIKit
import IHProgressHUD

class WeatherViewModel: NSObject {
    private var apiService: APIService!
    var onErrorHanlding: ((String) -> Void)?

    private(set) var weatherData: Weather! {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }
    
    var bindWeatherViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
    }
    
    func getWeatherData() {
        IHProgressHUD.show()
        if !Connectivity.isConnectedToInternet {
            let arr = DatabaseManager.shared.fetchForecast()
            if arr.isEmpty {
                self.onErrorHanlding?("No Data Available")
            } else {
                let weatherObject = Weather(forecast: arr, cityName: "", lon: "", timezone: "", lat: "", countryCode: "", stateCode: "")
                self.weatherData = weatherObject
            }
        } else {
            self.apiService?.apiToGetWeatherForecastData(unit: SettingManager.shared.getAPIMeasurment()) { (result,error)  in
                if error != nil {
                    //Show alert
                    self.onErrorHanlding?(error!)
                } else {
                    self.weatherData = result
                }
            }
        }
    }
    
    
    
}
