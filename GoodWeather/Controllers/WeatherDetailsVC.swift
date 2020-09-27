//
//  WeatherDetailsVC.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 26/09/20.
//

import UIKit

class WeatherDetailsVC: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    var weatherVM: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*self.cityNameLabel.text = weatherVM?.cityName.value
        self.currentTemperatureLabel.text = weatherVM?.temperature.value
        if let maxTemp = weatherVM?.maxTemperature.value {
            self.maxTemperatureLabel.text = "\(maxTemp)"
        }
        if let minTemp = weatherVM?.minTemperature.value {
            self.minTemperatureLabel.text = "\(minTemp)"
        }*/
        
        setupBindings()
    }
    
    private func setupBindings() {
        if let weatherVM = weatherVM {
            weatherVM.cityName.bind {
                self.cityNameLabel.text = $0
                print("This got called.")
            }
            weatherVM.temperature.bind { self.currentTemperatureLabel.text = $0 }
            weatherVM.maxTemperature.bind { self.maxTemperatureLabel.text = $0.formatAsDegree }
            weatherVM.minTemperature.bind { self.minTemperatureLabel.text = $0.formatAsDegree }
            print("City name's value is:", weatherVM.cityName.value)
            print("City name's Listener is:", weatherVM.cityName.listener)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.weatherVM?.cityName = Dynamic<String>("Mumbai")
                //self.weatherVM = weatherVM
                print(self.weatherVM)
            }
        }
    }
}
