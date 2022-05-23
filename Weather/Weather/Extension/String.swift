//
//  String.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//
import Foundation
extension String {
   
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let oldDate = dateFormatter.date(from: self) {
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.dateFormat = "EEEE"
            return convertDateFormatter.string(from: oldDate).capitalized
        } else {
            return "-"
        }
   }
    
    
}
