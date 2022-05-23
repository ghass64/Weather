//
//  AttributedString.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import UIKit

class AttributedString : NSObject {
    
    class func tempratureString(min: String, max: String) -> NSAttributedString {
        
        let maximumDegree = String(format: "%@° %@",max, SettingManager.shared.getMeasurment())
        let temprature = String(format: "%@ | %@° %@", maximumDegree, min, SettingManager.shared.getMeasurment())

        let maxRange = (temprature as NSString).range(of: maximumDegree)
        
        let attributedString = NSMutableAttributedString.init(string:temprature)
        if let font = UIFont(name: "AvenirNextCondensed-Bold", size: 20) {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: maxRange)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBackground, range: maxRange)
        }
         return attributedString
    }
    
    class func dateLiteString(fullDate: String) -> NSAttributedString {
        
        let dateArr = fullDate.components(separatedBy: "\n")
        var dateString = ""
        if dateArr.count > 0 {
            dateString = dateArr[1]
        }

        let range = (fullDate as NSString).range(of: dateString)
        
        let attributedString = NSMutableAttributedString.init(string:fullDate)
        if let font = UIFont(name: "AvenirNextCondensed-UltraLight", size: 10) {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
         return attributedString
    }
    
}

