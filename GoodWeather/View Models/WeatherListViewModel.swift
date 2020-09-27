//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import Foundation

struct WeatherListViewModel {
    private var weatherList = [WeatherViewModel]()
    
    var all: [WeatherViewModel] {
        return weatherList
    }
    
    mutating func addWeatherViewModel(vm: WeatherViewModel) {
        self.weatherList.append(vm)
    }
    
    mutating func updateWeatherList(vm: [WeatherViewModel]) {
        self.weatherList = vm
    }
    
    mutating private func toCelcius() {
        weatherList = weatherList.map { vm in
            var weatherModel = vm
            if let temp = Double(weatherModel.temperature.value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                weatherModel.temperature = Dynamic<String>("\(((temp - 32) * 5 / 9).formatAsDegree) C")
            }
            return weatherModel
        }
    }
    
    mutating private func toFahrenheit() {
        weatherList = weatherList.map { vm in
            var weatherModel = vm
            if let temp = Double(weatherModel.temperature.value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                weatherModel.temperature = Dynamic<String>("\((temp * 9 / 5 + 32).formatAsDegree) F")
            }
            return weatherModel
        }
    }
    
    mutating func updateUnit(to unit: Unit) {
        switch unit {
            case .celcius:
                toCelcius()
        case .fahrenheit:
                toFahrenheit()
        }
    }
}
