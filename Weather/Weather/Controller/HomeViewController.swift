//
//  ViewController.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import UIKit
import IHProgressHUD

class HomeViewController: UIViewController {
    
    //MARK: -IBOUTLET
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - ViewModel
    private var weatherViewModel: WeatherViewModel!
    
    //MARK: - DataSource
    private var dataSource: WeatherTableViewDataSource<WeatherTableViewCell,WeatherForecast>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = Constants.city
        updateUIFromViewModel()
    }
    
    
    //MARK: - Helper methods
    func updateUIFromViewModel() {
        self.weatherViewModel = WeatherViewModel()
        self.weatherViewModel.bindWeatherViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource() {
        self.dataSource = WeatherTableViewDataSource(cellIdentifier: "WeatherTableViewCell", data: self.weatherViewModel.weatherData.forecast, configureCell: { (cell, weather) in
            // configure cell UI element
            cell.setDateInCell(weather: weather)
        })
        
        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
            IHProgressHUD.dismiss()
        }
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

