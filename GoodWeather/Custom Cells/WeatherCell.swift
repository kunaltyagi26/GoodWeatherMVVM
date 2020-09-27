//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    func configure(_ vm: WeatherViewModel) {
        self.cityName.text = vm.cityName.value
        self.temperature.text = "\(vm.temperature.value)"
    }
}
