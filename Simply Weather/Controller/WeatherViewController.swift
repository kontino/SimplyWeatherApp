//
//  ViewController.swift
//  Simply Weather
//
//  Created by Konstantinos Gouzinis on 21/11/23.
//

import UIKit
import CoreLocation

class WeatherViewController : UIViewController, UITextFieldDelegate, WeatherDataManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var unitSelector: UISegmentedControl!
    @IBOutlet weak var unitSymbol: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherDataManager = WeatherDataManager(units: "metric")
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self //let the view controller know that this text field reports to it
        weatherDataManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }

    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        searchTextField.text = ""
    }
    
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        weatherDataManager.getWeatherByCoordinates(latitude: getLatitude(), longitude: getLongitude())
    }
    
    @IBAction func unitChanged(_ sender: UISegmentedControl) {
        // Handle the unit system toggle value change here
        let selectedIndex = sender.selectedSegmentIndex
        print("Segmented Control Value Changed: \(selectedIndex)")
        let updatedUnits = getWeatherUnits()
        weatherDataManager.units = updatedUnits
        weatherDataManager.getWeatherByCity(city: cityLabel.text ?? "Athens")
      
    }
    
    func getWeatherUnits() -> String{
        if unitSelector.selectedSegmentIndex == 0 {
            return "metric"
        } else {
            return "imperial"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Type a location"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let textInput = searchTextField.text{
            
            // Split the text by spaces
            let components = textInput.components(separatedBy: " ")

            // Check if there are exactly two components and each component is a valid number
            if components.count == 2, let firstNumber = Double(components[0]), let secondNumber = Double(components[1]) {
                print("User input contains two numbers separated by a space:")
                print("First Number: \(firstNumber)")
                print("Second Number: \(secondNumber)")
                weatherDataManager.getWeatherByCoordinates(latitude: firstNumber, longitude: secondNumber)
            } else if components.count == 1 {
                weatherDataManager.getWeatherByCity(city: textInput)
            } else {
                print("User input does not match the expected format.")
            }

        }
        // Clear out text field once user presses return key or search button
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureText
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionSymbol)
            self.lowLabel.text = weather.tempMinText
            self.highLabel.text = weather.tempMaxText
            if self.getWeatherUnits() == "metric" {
                self.unitSymbol.text = "C"
            } else{
                self.unitSymbol.text = "F"
            }
        }
        
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getLatitude() -> Double{
        if let location = self.locationManager.location{
            return location.coordinate.latitude
        }
        return 0
    }
    
    func getLongitude() -> Double{
        if let location = self.locationManager.location{
            return location.coordinate.longitude
        }
        return 0
    }
}
