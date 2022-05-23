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
    
    //MARK: - Timer
    var updateTimer: Timer?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        updateUIFromViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(HomeViewController.updateUIFromViewModel), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateTimer?.invalidate()
        completeUpdatingUI()
    }
    
    //MARK: - Helper methods
    func configureView() {
        self.title = Constants.city
        let settingBtn: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(self.settingButtonClicked))
        settingBtn.tintColor = UIColor.systemBackground
        self.navigationItem.rightBarButtonItems = [settingBtn]

        //add pull to refresh mechanism to the table
        addPullToRefresh()

    }
    
    @objc func updateUIFromViewModel() {
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
        IHProgressHUD.dismiss()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    //MARK: - Action
    @objc func settingButtonClicked() {
        let alert = UIAlertController(title: "Select Unit", message: "", preferredStyle: .actionSheet)
        let centigrade = UIAlertAction(title: "Centigrade", style: .default) { [weak self] _ in
            SettingManager.shared.setMeasurment(measurment: "M")
            self?.updateUIFromViewModel()
        }
        let fahrenheit = UIAlertAction(title: "Fahrenheit", style: .default) { [weak self] _ in
            SettingManager.shared.setMeasurment(measurment: "I")
            self?.updateUIFromViewModel()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(centigrade)
        alert.addAction(fahrenheit)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

