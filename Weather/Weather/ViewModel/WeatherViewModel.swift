//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import UIKit
import IHProgressHUD

class WeatherViewModel: NSObject {
    //MARK: - Variables
    private var apiService: APIService!
    var selectedForecast: WeatherForecast!
    var bindWeatherViewModelToController: (() -> ()) = {}
    private(set) var weatherData: Weather! {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }
    
    
    //MARK: - Delegations
    var onErrorHanlding: ((String) -> Void)?
    
    
    //MARK: - Initializer
    override init() {
        super.init()
        self.apiService = APIService()
    }
    
    //MARK: - Fetch Data
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
                    self.onErrorHanlding?(error!)
                } else {
                    self.weatherData = result
                }
            }
        }
    }
    
    //MARK: - Communication Methods
    func selectForecast(atIndex: Int) {
        selectedForecast = weatherData.forecast[atIndex]
    }
    
    func receive(_ forecast: WeatherForecast) {
        selectedForecast = forecast
    }
    
    
}
