//
//  AttributedString.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import UIKit

class AttributedString : NSObject {
    
    class func tempratureString(min: String, max: String) -> NSAttributedString {
        
        let temprature = String(format: "%@° | %@°", max, min)

        let maxRange = (temprature as NSString).range(of: max)
        
        let attributedString = NSMutableAttributedString.init(string:temprature)
        if let font = UIFont(name: "AvenirNextCondensed-Bold", size: 20) {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: maxRange)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBackground, range: maxRange)
        }
         return attributedString
    }
    
}

