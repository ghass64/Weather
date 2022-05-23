//
//  Weather.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather
struct Weather: Codable {
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
}

// MARK: - WeatherForecast
struct WeatherForecast: Codable {
    let moonriseTs: Double
    let windCdir: String
    let rh: Double
    let pres, highTemp: Double
    let sunsetTs: Double
    let ozone, moonPhase, windGustSpd: Double
    let snowDepth, clouds, ts, sunriseTs: Double
    let appMinTemp, windSpd: Double
    let pop: Double
    let windCdirFull: String
    let slp, moonPhaseLunation: Double
    let validDate: String
    let appMaxTemp, vis, dewpt: Double
    let snow: Double
    let uv: Double
    let weather: WeatherClass
    let windDir: Double
    let maxDhi: JSONNull?
    let cloudsHi, precip: Double
    let lowTemp, maxTemp: Double
    let moonsetTs: Double
    let datetime: String
    let temp, minTemp: Double
    let cloudsMid, cloudsLow: Double

    enum CodingKeys: String, CodingKey {
        case moonriseTs = "moonrise_ts"
        case windCdir = "wind_cdir"
        case rh, pres
        case highTemp = "high_temp"
        case sunsetTs = "sunset_ts"
        case ozone
        case moonPhase = "moon_phase"
        case windGustSpd = "wind_gust_spd"
        case snowDepth = "snow_depth"
        case clouds, ts
        case sunriseTs = "sunrise_ts"
        case appMinTemp = "app_min_temp"
        case windSpd = "wind_spd"
        case pop
        case windCdirFull = "wind_cdir_full"
        case slp
        case moonPhaseLunation = "moon_phase_lunation"
        case validDate = "valid_date"
        case appMaxTemp = "app_max_temp"
        case vis, dewpt, snow, uv, weather
        case windDir = "wind_dir"
        case maxDhi = "max_dhi"
        case cloudsHi = "clouds_hi"
        case precip
        case lowTemp = "low_temp"
        case maxTemp = "max_temp"
        case moonsetTs = "moonset_ts"
        case datetime, temp
        case minTemp = "min_temp"
        case cloudsMid = "clouds_mid"
        case cloudsLow = "clouds_low"
    }
}

// MARK: - WeatherClass
struct WeatherClass: Codable {
    let icon: String
    let code: Int
    let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case icon, code
        case weatherDescription = "description"
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
