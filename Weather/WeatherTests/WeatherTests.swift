//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testFetchApiService() throws {
        // given
        let apiService = APIService()
        
        // 1
        let promise = expectation(description: "Fetch Success")
        
        // when
        apiService.apiToGetWeatherForecastData(unit: "M") { result, error in
            if error != nil {
                XCTFail("Error: \(error ?? "")")
                return
            } else {
                promise.fulfill()
            }
        }
        // 3
        wait(for: [promise], timeout: 15)
    }
    
    func testWeatherViewModelBinding() {
        let viewModel = WeatherViewModel()
        
        let promise = expectation(description: "ViewModel Bind")
        
        viewModel.onErrorHanlding = { error in
            promise.fulfill()
        }
        viewModel.bindWeatherViewModelToController = {
            promise.fulfill()
        }
        
        viewModel.getWeatherData()
        
        wait(for: [promise], timeout: 15)

    }
    
    func testTableDataSource() {
        let viewModel = WeatherViewModel()
        var dataSource: WeatherTableViewDataSource<WeatherTableViewCell,WeatherForecast>!
        
        let promise = expectation(description: "Data source updated")
        
        viewModel.bindWeatherViewModelToController = {
            dataSource = WeatherTableViewDataSource(cellIdentifier: "WeatherTableViewCell", data: viewModel.weatherData.forecast, configureCell: { (cell, weather) in
                promise.fulfill()
            })
            XCTAssertNotNil(dataSource)
            promise.fulfill()
        }
        
        viewModel.getWeatherData()
        wait(for: [promise], timeout: 30)

    }
    
    func testTransferDataWithViewModel() {
        let viewModel = WeatherViewModel()
                
        let promise = expectation(description: "Object transfered successfully")
        
        viewModel.onErrorHanlding = { error in
            XCTFail(error)
        }
        viewModel.bindWeatherViewModelToController = {
            viewModel.selectForecast(atIndex: 0)
            let sentObject = viewModel.selectedForecast
            
            viewModel.receive(sentObject!)
            
            let recievedObject = viewModel.selectedForecast
            
            XCTAssertEqual(sentObject, recievedObject)
            promise.fulfill()
        }
        
        viewModel.getWeatherData()
        
        wait(for: [promise], timeout: 15)
    }
    

}
