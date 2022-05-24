//
//  DetailsViewController.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 24/05/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    
    //MARK: - ViewModel
    private var weatherViewModel = WeatherViewModel()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK: - Helpers
    func configureView() {
        let forecast: WeatherForecast = weatherViewModel.selectedForecast
        cityLabel.text = Constants.city
        weatherImage.image = UIImage(named: String(forecast.weather!.icon))
        dayLabel.text = forecast.datetime.dayOfWeek()
        
        let lowTemprature = String(format:"L:%.0f° %@",forecast.minTemp, SettingManager.shared.getMeasurment())
        let highTemprature = String(format:"H:%.0f° %@",forecast.maxTemp, SettingManager.shared.getMeasurment())
        tempratureLabel.text =  highTemprature + lowTemprature
    }
    
    func transfer(forecast: WeatherForecast) {
        weatherViewModel.receive(forecast)
    }
    
    
    //MARK: - Actions
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
