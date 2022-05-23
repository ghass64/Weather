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
        configureView()
        updateUIFromViewModel()
    }
    
    
    //MARK: - Helper methods
    func configureView() {
        self.title = Constants.city

        //add pull to refresh mechanism to the table
        addPullToRefresh()

    }
    
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
            self.completeUpdatingUI()
        }
    }
    
    private func addPullToRefresh() {
        //using UIRefreshControl to tableview and connect it with method to update
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action:#selector(self.handleRefresh), for: .valueChanged)
    }
    
    //method to call after pull to referesh to update the list
    @objc func handleRefresh() {
        updateUIFromViewModel()
    }
    
    func completeUpdatingUI() {
        self.tableView.reloadData()
        IHProgressHUD.dismiss()
        self.tableView.refreshControl?.endRefreshing()
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

