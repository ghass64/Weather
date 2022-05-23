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
    private(set) var weatherData: Weather! {
        didSet {
            self.bindWeatherViewModelToController()
        }
    }
    
    var bindWeatherViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        getWeatherData()
    }
    
    func getWeatherData() {
        IHProgressHUD.show()
        self.apiService?.apiToGetWeatherForecastData(unit: SettingManager.shared.getAPIMeasurment()) { result in
            self.weatherData = result
        }
    }
}
