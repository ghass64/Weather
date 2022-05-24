//
//  APIService.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import Foundation

class APIService: NSObject {

    private let sourceURL = URL(string: Constants.APIURL)!
    
    func apiToGetWeatherForecastData(unit: String, completion: @escaping (Weather?, String?) -> ()) {
        let apiString = String(format: "%@?city=%@&country=%@&days=%@&units=%@&key=%@",Constants.APIURL,Constants.city,Constants.countryCode,Constants.days,unit,Constants.apiKey)
        let sourceURL = URL(string: apiString)!

        URLSession.shared.dataTask(with: sourceURL) { Data, response, error in
            if let data = Data {
                do {
                    // process data
                    let jsonDecoder = JSONDecoder()
                    let weatherData = try jsonDecoder.decode(Weather.self, from: data)
                    completion(weatherData, nil)
                } catch DecodingError.dataCorrupted(_) {
                    completion(nil, "There is something wrong with the server please try again later")
                } catch DecodingError.keyNotFound(_, _) {
                    completion(nil, "There is something wrong with the server please try again later")
                } catch DecodingError.valueNotFound(_, _) {
                    completion(nil, "There is something wrong with the server please try again later")
                } catch DecodingError.typeMismatch(_, _)  {
                    completion(nil, "There is something wrong with the server please try again later")
                } catch {
                    print("error: ", error)
                    completion(nil, "There is something wrong with the server please try again later")
                }
            }
        }.resume()
    }
}
