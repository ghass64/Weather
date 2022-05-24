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
    private var weatherViewModel = WeatherViewModel()
    
    //MARK: - DataSource
    private var dataSource: WeatherTableViewDataSource<WeatherTableViewCell,WeatherForecast>!
    
    //MARK: - Timer
    var updateTimer: Timer?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewControllerWithViewModel()
        updateUIFromViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // schedule local notification
        NotificationManager.shared.scheduleNotification()
        
        // configure timer for background fetch data
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
        self.weatherViewModel.getWeatherData()
    }
    
    func bindViewControllerWithViewModel() {
        self.weatherViewModel.onErrorHanlding = { error in
            DispatchQueue.main.async {
                self.showAlertWith(message: error, title: "Info")
                self.completeUpdatingUI()
            }
        }
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
            DatabaseManager.shared.add(forecast: self.weatherViewModel.weatherData.forecast)
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
    
    //MARK: - AlertView Method
    private func showAlertWith(message: String, title: String) {
        let alertController = UIAlertController(title: title, message:
                                                    message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetailScreen" {
            guard let dest = segue.destination as? DetailsViewController else {
                return
            }
            dest.transfer(forecast: weatherViewModel.selectedForecast)
        }
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        weatherViewModel.selectForecast(atIndex: indexPath.row)
        self.performSegue(withIdentifier: "showDetailScreen", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

