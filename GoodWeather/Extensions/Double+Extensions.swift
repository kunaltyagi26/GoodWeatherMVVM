//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 21/09/20.
//

import Foundation

extension Double {
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
}
