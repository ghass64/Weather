//
//  Weather.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import Foundation
import RealmSwift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)


// MARK: - Weather
class Weather: NSObject, Codable {
    let forecast: [WeatherForecast]
    let cityName, lon, timezone, lat: String
    let countryCode, stateCode: String

    enum CodingKeys: String, CodingKey {
        case forecast = "data"
        case cityName = "city_name"
        case lon, timezone, lat
        case countryCode = "country_code"
        case stateCode = "state_code"
    }
    
    init(forecast: [WeatherForecast], cityName: String, lon: String, timezone: String, lat: String, countryCode: String, stateCode: String) {
            self.forecast = forecast
            self.cityName = cityName
            self.lon = lon
            self.timezone = timezone
            self.lat = lat
            self.countryCode = countryCode
            self.stateCode = stateCode
        }
}

// MARK: - WeatherForecast
class WeatherForecast: Object, Codable {
    @Persisted var weather: WeatherClass?
    @Persisted var maxTemp: Double
    @Persisted var datetime: String
    @Persisted var minTemp: Double

    enum CodingKeys: String, CodingKey {
        case weather
        case maxTemp = "max_temp"
        case datetime
        case minTemp = "min_temp"
    }
    
    convenience init(weather: WeatherClass, maxTemp: Double, datetime: String, minTemp: Double) {
        self.init()
        self.weather = weather
        self.maxTemp = maxTemp
        self.datetime = datetime
        self.minTemp = minTemp
    }
}

// MARK: - WeatherClass
class WeatherClass: Object, Codable {
    @Persisted var icon: String
    @Persisted var code: Int
    @Persisted var weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case icon, code
        case weatherDescription = "description"
    }
    
    convenience init(icon: String, code: Int, weatherDescription: String) {
        self.init()
            self.icon = icon
            self.code = code
            self.weatherDescription = weatherDescription
        }
}


// MARK: - Enum WeatherMeasurement
enum WeatherMeasurement:String {
    
    case centigrade
    case fahrenheit
}

// MARK: - JSONNull
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    // MARK: - Encode/decode helpers
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
