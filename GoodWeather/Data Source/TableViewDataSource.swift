//
//  TableViewDataSource.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 27/09/20.
//

import Foundation
import UIKit

class TableViewDataSource<CellType, ViewModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    let cellIdentifier: String
    var items: [ViewModel]
    
    let configureCell: (CellType, ViewModel)-> ()
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping (CellType, ViewModel)-> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func updateDataSource(vm: [ViewModel]) {
        self.items = vm
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else { return UITableViewCell() }
        let item = items[indexPath.row]
        configureCell(cell, item)
        return cell
    }
}
