//
//  SettingsVC.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 21/09/20.
//

import UIKit

protocol SettingsVCDelegate: NSObject {
    func updateList(vm: SettingsViewModel)
}

class SettingsVC: UITableViewController {

    var settingsVM = SettingsViewModel()
    weak var delegate: SettingsVCDelegate?
    let initialSelectedUnit: Unit = SettingsViewModel().selectedUnit
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        if let selectedIndex = tableView.indexPathForSelectedRow?.row {
            settingsVM.selectedUnit = settingsVM.all[selectedIndex]
            self.navigationController?.popViewController(animated: true)
            if initialSelectedUnit != settingsVM.selectedUnit {
                self.delegate?.updateList(vm: settingsVM)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return settingsVM.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = settingsVM.all[indexPath.row].displayName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        cell.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let selectedUnit = settingsVM.selectedUnit
        guard let index = settingsVM.all.firstIndex(of: selectedUnit) else { return }
        
        if index == indexPath.row {
            DispatchQueue.main.async {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
            }
            
        }
    }

}
