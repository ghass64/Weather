//
//  Constant.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

enum Constants {
    static let city = "Dubai"
    static let countryCode = "AE"
    static let apiKey = "9686aff607434c4f9c4aeb861bf68765"
    static let days = "10"
    static let APIURL = String(format: "https://api.weatherbit.io/v2.0/forecast/daily?city=%@&country=%@&days=%@&key=%@",Constants.city,Constants.countryCode,Constants.days,Constants.apiKey)
}
