//
//  WeatherModel.swift
//  Simply Weather
//
//  Created by Konstantinos Gouzinis on 22/11/23.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let conditionID: Int
    let temperature: Double
    let tempMin: Double
    let tempMax: Double
    
    var temperatureText: String{
        return String(Int(round(temperature)))
    }
    
    var tempMinText: String{
        return String(Int(round(tempMin)))
    }
    
    var tempMaxText: String{
        return String(Int(round(tempMax)))
    }
    
    var conditionSymbol: String {
        switch conditionID {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud.bolt"
                default:
                    return "cloud"
                }

    }
    
}
