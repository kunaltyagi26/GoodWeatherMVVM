//
//  Weather.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String?
    let main: Weather?
    let message: String?
}

struct Weather: Codable {
    var temperature: Double?
    var temperatureMin: Double?
    var temperatureMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
