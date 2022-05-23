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

    var weatherItem : WeatherForecast? {
        didSet {
            // prepare data
            guard let imageName = weatherItem?.weather.code else { return }
            guard let lowTemprature = weatherItem?.maxTemp else { return }
            guard let highTemprature = weatherItem?.minTemp else { return }

            dayLabel.text = weatherItem?.datetime.dayOfWeek()
            tempratureLabel.attributedText = AttributedString.tempratureString(min: String(lowTemprature), max: String(highTemprature))
            weatherImage.image = UIImage(named: String(imageName))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
