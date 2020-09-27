//
//  Webservice.swift
//  GoodWeather
//
//  Created by Kunal Tyagi on 20/09/20.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data)-> T?
}

final class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping (T?)-> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            if let data = data, error == nil {
                //print(String(data: data, encoding: .utf8))
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
