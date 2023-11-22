//
//  WeatherData.swift
//  Simply Weather
//
//  Created by Konstantinos Gouzinis on 21/11/23.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable {
    let id: Int
}
