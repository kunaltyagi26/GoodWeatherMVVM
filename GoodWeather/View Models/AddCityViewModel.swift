//
//  AddCityViewModel.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import Foundation

struct AddCityViewModel {
    var city: String = ""
    var state: String = ""
    var zipCode: String = ""
    
    func fetchWeather(by city: String, completion: @escaping (WeatherViewModel?, String?)-> ()) {
        let apiKey = "85c96101d79fbf8ddbb2ed2a803422f8"
        guard let unitValue = UserDefaults.standard.value(forKey: "unit") as? String, let unit = Unit(rawValue: unitValue) else { return }
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=\(unit.rawValue)") else { return }
        var errorMsg = ""
        let resource = Resource<WeatherViewModel>(url: url) { (data) -> WeatherViewModel? in
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                if let errorMessage =  weatherResponse.message {
                    errorMsg = errorMessage
                    return nil
                } else {
                    if let weather = weatherResponse.main, let name = weatherResponse.name {
                        let weatherViewModel = WeatherViewModel(weather: weather, name: name)
                        return weatherViewModel
                    } else {
                        return nil
                    }
                }
            } catch {
                print(error)
                return nil
            }
        }
        
        Webservice().load(resource: resource) { (weatherVM) in
            if errorMsg == "" {
                if let weatherVM = weatherVM {
                    completion(weatherVM, nil)
                } else {
                    completion(nil, nil)
                }
            } else {
                completion(nil, errorMsg)
            }
        }
    }
}
