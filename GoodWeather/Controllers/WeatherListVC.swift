//
//  WeatherListVC.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import UIKit

class WeatherListVC: UITableViewController {

    private var weatherListVM = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCitySegue" {
            let addCityVC = segue.destination as? AddCityVC
            addCityVC?.delegate = self
        } else if segue.identifier == "settingsSegue" {
            let settingsVC = segue.destination as? SettingsVC
            settingsVC?.delegate = self
        } else if segue.identifier == "weatherDetailSegue" {
            guard let weatherDetailVC = segue.destination as? WeatherDetailsVC, let indexPath = self.tableView.indexPathForSelectedRow else { return }
            let weatherVM = weatherListVM.all[indexPath.row]
            weatherDetailVC.weatherVM = weatherVM
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherListVM.all.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell else { return UITableViewCell() }
        let vm = weatherListVM.all[indexPath.row]
        cell.configure(vm)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension WeatherListVC: AddCityVCDelegate {
    func addCityToList(vm: WeatherViewModel) {
        DispatchQueue.main.async {
            self.weatherListVM.addWeatherViewModel(vm: vm)
            self.tableView.insertRows(at: [IndexPath(row: self.weatherListVM.all.count - 1, section: 0)], with: .automatic)
        }
    }
}

extension WeatherListVC: SettingsVCDelegate {
    func updateList(vm: SettingsViewModel) {
        self.weatherListVM.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
    }
}
