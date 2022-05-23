//
//  APIService.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import Foundation

class APIService: NSObject {

    private let sourceURL = URL(string: Constants.APIURL)!
    
    func apiToGetWeatherForecastData(completion: @escaping (Weather) -> ()) {
        URLSession.shared.dataTask(with: sourceURL) { Data, response, error in
            if let data = Data {
                let jsonDecoder = JSONDecoder()
                let weatherData = try! jsonDecoder.decode(Weather.self, from: data)
                completion(weatherData)
            }
        }.resume()
    }
}
