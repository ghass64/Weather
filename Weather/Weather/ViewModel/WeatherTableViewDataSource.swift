//
//  WeatherTableViewDataSource.swift
//  Weather
//
//  Created by Ghassan Fathi Al Marei on 23/05/2022.
//

import UIKit

class WeatherTableViewDataSource<CELL: UITableViewCell, T> : NSObject, UITableViewDataSource {
    private var cellIdentifier: String!
    private var data: [T]!
    var configureCell: (CELL, T) -> () = {_,_ in}

    init(cellIdentifier: String, data: [T], configureCell: @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.data = data
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CELL
        let weatherData = self.data[indexPath.row]
        self.configureCell(cell, weatherData)
        return cell
    }

}
