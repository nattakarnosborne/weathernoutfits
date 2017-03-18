//
//  ViewController.swift
//  WeatherNow
//
//  Created by Nattakarn Osborne on 12/26/16.
//  Copyright © 2016 Nattakarn Osborne. All rights reserved.
//

import UIKit

protocol WeatherGetterDelegate {
    
    func didGetWeather(_ weather: Weather)
    func didNotGetWeather(_ error: NSError)
    
}
class WeatherGetter {
    
    fileprivate var openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
//    fileprivate var openWeatherMapBaseURL = " http://api.openweathermap.org/data/2.5/forecast/daily?lat=-16.92&lon=145.77&cnt=7&APPID=3a798fbdfa5bd473e1efff3db38d526c"
//    http://api.openweathermap.org/data/2.5/forecast/daily?lat=-16.92&lon=145.77&cnt=7&APPID=3a798fbdfa5bd473e1efff3db38d526c
    
    var openWeatherMapDailyURL = " http://api.openweathermap.org/data/2.5/forecast/daily?"

    fileprivate var openWeatherMapAPIKey = "3a798fbdfa5bd473e1efff3db38d526c"

    fileprivate var delegate: WeatherGetterDelegate
    
// MARK: -

    
    init(delegate: WeatherGetterDelegate){
        
        self.delegate = delegate
    }
    
    func getWeatherByCity(city: String) {
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        getWeather(weatherRequestURL: weatherRequestURL)
    }
    
    func getWeatherByCoordinates(latitude: Double, longitude: Double) {
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&lat=\(latitude)&lon=\(longitude)")!
        getWeather(weatherRequestURL: weatherRequestURL)
    }
    

    fileprivate func getWeather(weatherRequestURL: NSURL) {
        
        // This is a pretty simple networking task, so the shared session will do.
        let session = URLSession.shared
        session.configuration.timeoutIntervalForRequest = 3
        
        var request = URLRequest(url: weatherRequestURL as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "data=Hello"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        

            let task = session.dataTask(with: request as URLRequest) {
                    (
                data, response, error) in
        
                guard let data = data, let _:URLResponse = response, error == nil else {
        
                    self.delegate.didNotGetWeather(error as! NSError)
        
                        return
                }
        
                    do {
                        // convert JSON to dictionary
                    let weatherData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
        
        
                    let weather = Weather(weatherData: weatherData as [String : AnyObject])
        
                        // Now that we have the Weather struct, let's notify the view controller,
                        // which will use it to display the weather to the user.
                    self.delegate.didGetWeather(weather)
                    print(weatherData)
        
                    } catch let error as NSError {

                    self.delegate.didNotGetWeather(error)

                        print(error)
                    }
                
                }
                
                task.resume()
    
    }
    
    

    
//    func getWeather(_ city: String) {
//        
//
//       let url = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
//        
////        let url = NSURL(string: "\(openWeatherMapBaseURL)\(city),us&mode=xml&appid=\(openWeatherMapAPIKey)")
//       
//        let session = URLSession.shared
//        
//        var request = URLRequest(url: url as URL)
//        request.httpMethod = "POST"
//        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
//        
//        let paramString = "data=Hello"
//        request.httpBody = paramString.data(using: String.Encoding.utf8)
//        
//        let task = session.dataTask(with: request as URLRequest) {
//            (
//            data, response, error) in
//            
//            guard let data = data, let _:URLResponse = response, error == nil else {
//                
//                self.delegate.didNotGetWeather(error as! NSError)
//                
//                return
//            }
//            
////            let dataString =  String(data: data, encoding: String.Encoding.utf8)
////            print("Data:\n\(dataString!)")
//            do {
//                // convert JSON to dictionary
//                let weatherData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
//                
// 
//                let weather = Weather(weatherData: weatherData as [String : AnyObject])
//                
//                // Now that we have the Weather struct, let's notify the view controller,
//                // which will use it to display the weather to the user.
//                self.delegate.didGetWeather(weather)
//                print(weatherData)
//                
//            } catch let error as NSError {
////                if error.code == 502{
////                    
////                    print("Not found city")
////                }
//                print(error)
//            }
//        
//        }
//        
//        task.resume()
//    }
    


}

