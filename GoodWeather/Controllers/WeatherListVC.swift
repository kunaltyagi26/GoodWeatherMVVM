//
//  WeatherListVC.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import UIKit

class WeatherListVC: UITableViewController {

    private var weatherListVM = WeatherListViewModel()
    private var dataSource: TableViewDataSource<WeatherCell, WeatherViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dataSource = TableViewDataSource(cellIdentifier: "weatherCell", items: self.weatherListVM.all, configureCell: { (cell, vm) in
            cell.configure(vm)
        })
        self.tableView.dataSource = dataSource
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension WeatherListVC: AddCityVCDelegate {
    func addCityToList(vm: WeatherViewModel) {
        DispatchQueue.main.async {
            self.weatherListVM.addWeatherViewModel(vm: vm)
            self.dataSource?.updateDataSource(vm: self.weatherListVM.all)
            self.tableView.insertRows(at: [IndexPath(row: self.weatherListVM.all.count - 1, section: 0)], with: .automatic)
        }
    }
}

extension WeatherListVC: SettingsVCDelegate {
    func updateList(vm: SettingsViewModel) {
        self.weatherListVM.updateUnit(to: vm.selectedUnit)
        self.dataSource?.updateDataSource(vm: self.weatherListVM.all)
        self.tableView.reloadData()
    }
}
