//
//  WeatherDataSource.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 27/09/20.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    var cellIdentifier: String = "weatherCell"
    private var weatherListVM: WeatherListViewModel
    
    init(_ weatherListViewModel: WeatherListViewModel) {
        self.weatherListVM = weatherListViewModel
    }
    
    func updateDataSource(vm: WeatherListViewModel) {
        self.weatherListVM = vm
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListVM.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        let vm = weatherListVM.all[indexPath.row]
        cell.configure(vm)
        return cell
    }
}
