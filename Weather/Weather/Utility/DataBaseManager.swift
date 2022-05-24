//
//  DataBaseManager.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 24/05/2022.
//

import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let realm = try! Realm()
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Work With Objects
    
    func delete(objects: [Object]) {
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    // MARK: - Work With WeatherForcasts
    
    func add(forecast: [WeatherForecast]) {
        try! realm.write {
            realm.add(forecast)
        }
        
    }
    
    func fetchForecast() -> [WeatherForecast] {
        return Array(realm.objects(WeatherForecast.self))
    }
    
}
