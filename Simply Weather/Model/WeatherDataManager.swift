//
//  WeatherDataManager.swift
//  Clima
//
//  Created by Konstantinos Gouzinis on 21/11/23.
//

import Foundation

// Set this Whe WeatherDataManager class as the delegate so that any kind of VC can use it
protocol WeatherDataManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherDataManager {
    //let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=bfe1e114baa90737ceb50092dc5005a8"
    let openWeatherMapCallURL = "https://api.openweathermap.org/data/2.5/weather?"
    let myAPIKey = "bfe1e114baa90737ceb50092dc5005a8"
    var units: String
    
    var delegate: WeatherDataManagerDelegate?
    
    func getWeatherByCity(city: String) {
        let weatherURL =  "\(openWeatherMapCallURL)appid=\(myAPIKey)&q=\(city)&units=\(units)"
        makeRequest(urlStr: weatherURL)
      }
      
      func getWeatherByCoordinates(latitude: Double, longitude: Double) {
        let weatherURL = "\(openWeatherMapCallURL)appid=\(myAPIKey)&lat=\(latitude)&lon=\(longitude)&units=\(units)"
          print(weatherURL)
        makeRequest(urlStr: weatherURL)
      }
    
    func makeRequest(urlStr: String) {
        if let url = URL(string: urlStr) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    // inside closure, self keyword is required by compiler
                    if let weather = self.parseJSON(weatherData: safeData) {
                        // Use delegate design pattern to make the WeatherDataManager struct reusable
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) // WeatherData.self signifies the data type
            let temperature = decodedData.main.temp
            let conditionID = decodedData.weather[0].id
            let cityName = decodedData.name
            let tempMin = decodedData.main.temp_min
            let tempMax = decodedData.main.temp_max
            
            let myWeather = WeatherModel(cityName: cityName, conditionID: conditionID, temperature: temperature, tempMin: tempMin, tempMax: tempMax)
            return myWeather
            
        } catch {
            print(error)
            return nil
        }
    }
    
    
}
