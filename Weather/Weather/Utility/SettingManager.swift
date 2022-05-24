//
//  SettingManager.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 24/05/2022.
//

import Foundation
import Reachability

class SettingManager {
    public static let shared = SettingManager()

    func setMeasurment(measurment:String) {
        let prefs = UserDefaults.standard
        if measurment != "" {
            prefs.set(measurment, forKey: Constants.wSettingKeyMeasurment)
        }else
        {
            prefs.removeObject(forKey: Constants.wSettingKeyMeasurment)
        }
        prefs.synchronize()
    }
    
    func getAPIMeasurment() -> String {
        let prefs = UserDefaults.standard
        let flag = prefs.object(forKey: Constants.wSettingKeyMeasurment)
        if flag != nil {
            return flag as! String
        } else {
            return "M"
        }
    }
    
    func getMeasurment() -> String {
        let prefs = UserDefaults.standard
        var measurment = ""
        let flag = prefs.object(forKey: Constants.wSettingKeyMeasurment)
        if flag != nil {
            measurment = flag as! String
            if measurment == "M" {
                return "C"
            } else {
                return "F"
            }
        } else {
            return "C"
        }
    }
}

class Connectivity {
    class var isConnectedToInternet: Bool {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            return false
        } else {
            return true
        }
    }
}
