//
//  Weather.swift
//  WeatherNow
//
//  Created by Nattakarn Osborne on 12/26/16.
//  Copyright © 2016 Nattakarn Osborne. All rights reserved.
//

import Foundation

struct Weather {
    
    let dateAndTime: NSDate
    
    let city: String
    let country: String
    let longitude: Double
    let latitude: Double
    
    let weatherID: Int
    let mainWeather: String
    let weatherDescription: String
    let weatherIconID: String
    
    // OpenWeatherMap reports temperature in Kelvin,
    // which is why we provide celsius and fahrenheit
    // computed properties.
    private let temp: Double
    
    var tempCelsius: Double {
        get {
            return temp - 273.15
        }
    }
    var tempFahrenheit: Double {
        get {
            return (temp - 273.15) * 1.8 + 32
        }
    }
    
    private let temp_max: Double
    var tempMax: Double {
        get {
            return (temp_max - 273.15) * 1.8 + 32
        }
    }
    
    private let temp_min: Double
    var tempMin: Double {
        get {
            return (temp_min - 273.15) * 1.8 + 32
        }
    }
    
    
    let humidity: Int
    let pressure: Int
    let cloudCover: Int
    let windSpeed: Double
    
    // These properties are optionals because OpenWeatherMap doesn't provide:
    // - a value for wind direction when the wind speed is negligible
    // - rain info when there is no rainfall
    let windDirection: Double?
    let rainfallInLast3Hours: Double?
    
    let sunrise: NSDate
    let sunset: NSDate

    
    init(weatherData: [String: AnyObject]) {
        
        dateAndTime = Date(timeIntervalSince1970: weatherData["dt"] as! TimeInterval) as NSDate
        city = weatherData["name"] as! String

        let coordDict = weatherData["coord"] as! [String: AnyObject]
        longitude = coordDict["lon"] as! Double
        latitude = coordDict["lat"] as! Double
        
        let weatherDict = weatherData["weather"]![0] as! [String: AnyObject]
        weatherID = weatherDict["id"] as! Int
        mainWeather = weatherDict["main"] as! String
        weatherDescription = weatherDict["description"] as! String
        weatherIconID = weatherDict["icon"] as! String
        
        let mainDict = weatherData["main"] as! [String: AnyObject]
        temp = mainDict["temp"] as! Double
        temp_max = mainDict["temp_max"] as! Double
        temp_min = mainDict["temp_min"] as! Double
        humidity = mainDict["humidity"] as! Int
        pressure = mainDict["pressure"] as! Int
        
        cloudCover = weatherData["clouds"]!["all"] as! Int
        
        let windDict = weatherData["wind"] as! [String: AnyObject]
        windSpeed = windDict["speed"] as! Double
        windDirection = windDict["deg"] as? Double
        
        if weatherData["rain"] != nil {
            let rainDict = weatherData["rain"] as! [String: AnyObject]
            rainfallInLast3Hours = rainDict["3h"] as? Double
        }
        else {
            rainfallInLast3Hours = nil
        }
        
        let sysDict = weatherData["sys"] as! [String: AnyObject]
        country = sysDict["country"] as! String
        sunrise = Date(timeIntervalSince1970: sysDict["sunrise"] as! TimeInterval) as NSDate
        sunset = Date(timeIntervalSince1970:sysDict["sunset"] as! TimeInterval) as NSDate
        
        
    }
    
}
