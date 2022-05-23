//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setDateInCell(weather: WeatherForecast) {
        self.dayLabel.attributedText =  AttributedString.dateLiteString(fullDate:String(format:"%@\n%@",weather.datetime.dayOfWeek(),weather.datetime))
        self.tempratureLabel.attributedText = AttributedString.tempratureString(min: String(format:"%.0f",weather.minTemp), max: String(format:"%.0f",weather.maxTemp))
        self.weatherImage.image = UIImage(named: String(weather.weather.icon))
    }

}
