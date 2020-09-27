//
//  WeatherViewModel.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import Foundation

class Dynamic<T>: Decodable where T: Decodable {
    typealias Listener = (T)-> ()
    
    var listener: Listener? = { _ in
        print("Random got called.")
    }
    
    var value: T {
        didSet {
            print("Value is set and listener is being called.")
            print("Listener is:", self.listener)
            self.listener?(value)
            print("Listener called at didSet of value.")
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        print("Listener is:", self.listener)
        self.listener?(self.value)
        print("Listener called.")
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}

struct WeatherViewModel {
    private var weather: Weather?
    private var name: String?
    
    init(weather: Weather, name: String) {
        self.weather = weather
        self.name = name
    }
    
    var temperature: Dynamic<String> {
        get {
            guard let weather = weather, let temp = weather.temperature else { return Dynamic<String>("") }
            var unitText = ""
            if let unitValue = UserDefaults.standard.value(forKey: "unit") as? String, let unit = Unit(rawValue: unitValue) {
                if unit == .celcius {
                    unitText = "C"
                } else {
                    unitText = "F"
                }
            } else {
                unitText = "F"
            }
            
            return Dynamic<String>("\(temp.formatAsDegree) \(unitText)")
        }
        set {
            if let temp = Double(newValue.value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                self.weather?.temperature = temp
            }
        }
    }
    
    var cityName: Dynamic<String> {
        get {
            guard let name = self.name else { return Dynamic<String>("") }
            return Dynamic<String>(name)
        }
        set {
            self.name = newValue.value
            self.cityName.value = newValue.value
            
            print("City name is:", self.name)
        }
    }
    
    var maxTemperature: Dynamic<Double> {
        get {
            guard let maxTemp = self.weather?.temperatureMax else { return Dynamic<Double>(0.0) }
            return Dynamic<Double>(maxTemp)
        }
        set {
            self.weather?.temperatureMax = newValue.value
        }
    }
    
    var minTemperature: Dynamic<Double> {
        get {
            guard let minTemp = self.weather?.temperatureMin else { return Dynamic<Double>(0.0) }
            return Dynamic<Double>(minTemp)
        }
        set {
            self.weather?.temperatureMin = newValue.value
        }
    }
}
