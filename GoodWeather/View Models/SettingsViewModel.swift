//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 21/09/20.
//

import Foundation

enum Unit: String, CaseIterable {
    case celcius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName: String {
        get {
            switch self {
            case .celcius:
                return "Celcius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    private let units = Unit.allCases
    private var _selectedUnit: Unit = Unit.fahrenheit
    
    var all: [Unit] {
        return units
    }
    
    var selectedUnit: Unit {
        get {
            guard let unitText = UserDefaults.standard.value(forKey: "unit") as? String, let unit = Unit(rawValue: unitText) else { return _selectedUnit}
            return unit
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "unit")
        }
    }
}
