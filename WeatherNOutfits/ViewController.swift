//
//  ViewController.swift
//  WeatherNow
//
//  Created by Nattakarn Osborne on 12/26/16.
//  Copyright © 2016 Nattakarn Osborne. All rights reserved.
//

import UIKit
import CoreLocation

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.

var temp: Int = 0


class ViewController: UIViewController, WeatherGetterDelegate,
UITextFieldDelegate, CLLocationManagerDelegate{

    
    lazy var topView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: (UIImage(named: "Summer Sunny")?.withRenderingMode(.alwaysOriginal))!)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        
        return view
        
    }()
    

    
    var cityLabel: UITextField = {
        
        let label = UITextField()
        
        label.text = "----"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(250, g: 250, b: 250)
        label.font = label.font?.withSize(30)
        
        label.returnKeyType = .default
        var glowColor = UIColor.gray
        label.layer.shadowColor = glowColor.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize.zero
        label.layer.masksToBounds = false
        return label
        
        
    }()
    
    var descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "---"
        label.textAlignment = .left
        label.textColor = UIColor.rgb(250, g: 250, b: 250)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(12)
        
        var glowColor = UIColor.gray
        label.layer.shadowColor = glowColor.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize.zero
        label.layer.masksToBounds = false
        
        
        return label
        
        
    }()
    
    var maxLabel: UILabel = {
        
        let label = UILabel()
        label.text = "---"
        label.textAlignment = .left
        label.textColor = UIColor.rgb(250, g: 250, b: 250)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(12)
        
        var glowColor = UIColor.gray
        label.layer.shadowColor = glowColor.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize.zero
        label.layer.masksToBounds = false
        
        
        return label
        
        
    }()
    
    var minLabel: UILabel = {
        
        let label = UILabel()
        label.text = "---"
        label.textAlignment = .left
        label.textColor = UIColor.rgb(250, g: 250, b: 250)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(12)
        
        var glowColor = UIColor.gray
        label.layer.shadowColor = glowColor.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize.zero
        label.layer.masksToBounds = false
        
        
        return label
        
        
    }()
    
    var dateLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Today"
        label.textAlignment = .left
        label.textColor = UIColor.rgb(250, g: 250, b: 250)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(13)
        
        var glowColor = UIColor.gray
        label.layer.shadowColor = glowColor.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize.zero
        label.layer.masksToBounds = false
        
        return label
        
        
    }()
    
    var temperatureLabel: UILabel = {
        
        let label = UILabel()
//        label.text = "- F"
        label.textAlignment = .left
        label.textColor = UIColor.rgb(250, g: 250, b: 250)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = label.font.withSize(64)
        
        var glowColor = UIColor.gray
        label.layer.shadowColor = glowColor.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize.zero
        label.layer.masksToBounds = false
        
        return label
        
        
    }()
    

    
    lazy var getLocationWeatherButton: UIButton = {
        
        let image = UIImage(named: "Current Location")?.withRenderingMode(.alwaysTemplate)
        
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(getWeatherForLocationButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var getCityWeatherButton: UIButton = {
        
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImage(named: "search")
//        button.tintColor = UIColor.rgb(255, g: 255, b: 255)
//        button.setImage(image, for: UIControlState())
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "search")
        button.tintColor = UIColor.rgb(255, g: 255, b: 255)
        button.setImage(image, for: UIControlState())
        button.layer.borderColor = UIColor.rgb(255, g: 255, b: 255).cgColor

        button.addTarget(self, action: #selector(getWeatherForCityButtonTapped), for: .touchUpInside)
        
        return button
    }()

    let locationManager = CLLocationManager()
    var weather: WeatherGetter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weather = WeatherGetter(delegate: self)

        getLocation()
        getDate()
        getMonth()
        setupTopView()
        setupNavBar()
        
    }
    
    func setupNavBar(){
    
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
        
        self.view.addSubview(navBar)
        let navItem = UINavigationItem()
//        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
      //  let searchCityButton = UIBarButtonItem(image: searchImage, style: .plain, target: nil, action: #selector(handleSearch))
        
        //comeback and fix color
        navItem.rightBarButtonItem = UIBarButtonItem(title: "What to wear", style: .plain, target: self, action: #selector(handleSearch))
        navItem.rightBarButtonItem?.tintColor = .white
 //      navItem.rightBarButtonItem = searchCityButton;
        navBar.setItems([navItem], animated: false);
        
    }
    
    let settingWhatToWear = WhatToWear()
    
    func handleSearch(){
        
        settingWhatToWear.showWhatTowear()
        
        
    }

    
    // MARK: - Background events
    func getDate(){
    
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
        self.dateLabel.text = (dateFormatter.string(from: date))

    }
    
    func getMonth(){
    
        let date = Date()

        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: date)
   

        print(month)
        

        switch month {
            
        case 3,4,5:
            
            print("This month is spring")
        case 6,7,8:
            
            print("This month is summer")
            
        case 9,10,11:
            
            print("This month is fall")
            
        default:
            
            topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Winter Raining")?.withRenderingMode(.alwaysOriginal))!)
        }


    }
    
    
    
    
    
    // MARK: - Button events and states
    // --------------------------------
    
    func getWeatherForLocationButtonTapped() {
        setWeatherButtonStates(true)
        getLocation()
        print("tap")
    }
    
    func getWeatherForCityButtonTapped() {
        
        guard let text = cityLabel.text, !text.trimmed.isEmpty else {
            return
        }
        setWeatherButtonStates(false)
        weather.getWeatherByCity(city: cityLabel.text!.urlEncoded)
   
        setWeatherButtonStates(false)
        weather.getWeatherByCity(city: cityLabel.text!.urlEncoded)
        
       
    }
    
    func setWeatherButtonStates(_ state: Bool) {
        getLocationWeatherButton.isEnabled = state
        getCityWeatherButton.isEnabled = state
    }
    
    
    // MARK: - WeatherGetterDelegate methods
    // -----------------------------------
    
    
    
 
    
    
    func didGetWeather(_ weather: Weather) {
        // This method is called asynchronously, which means it won't execute in the main queue.
        // All UI code needs to execute in the main queue, which is why we're wrapping the code
        // that updates all the labels in a dispatch_async() call.
        performUIUpdatesOnMain {
            
            self.cityLabel.text = weather.city

            self.temperatureLabel.text = "\(Int(round(weather.tempFahrenheit)))° F"
            self.descriptionLabel.text = "\(weather.weatherDescription)"
            self.maxLabel.text = "\(Int(round(weather.tempMax)))°/"
            self.minLabel.text = "\(Int(round(weather.tempMin)))°"

            print("\(Int(round(weather.tempMax)))° / ", "\(Int(round(weather.tempMin)))°")
            
            
            temp = Int(round(weather.tempFahrenheit))
            
            
            

            
            let currentWeatherDescription = weather.weatherDescription
            

                
                switch currentWeatherDescription{
                    
                case "thunderstorm with light rain","thunderstorm with rain","thunderstorm with heavy rain","light thunderstorm","thunderstorm", "heavy thunderstorm", "ragged thunderstorm","thunderstorm with light drizzle", "thunderstorm with drizzle", "thunderstorm with heavy drizzle":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Thunder")?.withRenderingMode(.alwaysOriginal))!)
                
                case "light intensity drizzle","drizzle","heavy intensity drizzle","light intensity drizzle rain", "drizzle rain", "heavy intensity drizzle rain","shower rain and drizzle", "heavy shower rain and drizzle", "shower drizzle":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Raining")?.withRenderingMode(.alwaysOriginal))!)
                    
                case "light rain","moderate rain","heavy intensity rain","very heavy rain", "extreme rain", "freezing rain","light intensity shower rain", "shower rain", "heavy intensity shower rain", "ragged shower rain":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Raining")?.withRenderingMode(.alwaysOriginal))!)
                    
                case "light snow","snow","heavy snow","sleet", "shower sleet", "light rain and snow","rain and snow", "light shower snow", "shower snow", "heavy shower snow":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Winter Snowing")?.withRenderingMode(.alwaysOriginal))!)
                    
                case "mist","smoke","haze","sand, dust whirls", "fog", "sand","dust", "volcanic ash", "squalls", "tornado":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Winter Mist")?.withRenderingMode(.alwaysOriginal))!)

                    
                case "clear sky":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Clear sky")?.withRenderingMode(.alwaysOriginal))!)
                    
                case "few clouds","scattered clouds","broken clouds", "overcast clouds":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Winter Mostly cloudy")?.withRenderingMode(.alwaysOriginal))!)
                    

                case "tornado","tropical storm","hurricane", "cold", "hot", "windy", "hail":
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Winter Raining")?.withRenderingMode(.alwaysOriginal))!)

                    
                default:
                    
                    self.topView.backgroundColor = UIColor(patternImage: (UIImage(named: "Summer Sunny")?.withRenderingMode(.alwaysOriginal))!)
                    
                }
            

                
            self.getLocationWeatherButton.isEnabled = true
            self.getCityWeatherButton.isEnabled = (self.cityLabel.text?.characters.count)! > 0
            
        }
    }
    

    
    func didNotGetWeather(_ error: NSError) {
        // This method is called asynchronously, which means it won't execute in the main queue.
        // All UI code needs to execute in the main queue, which is why we're wrapping the call
        // to showSimpleAlert(title:message:) in a dispatch_async() call.
        performUIUpdatesOnMain {
            self.showSimpleAlert(title: "Can't get the weather",
                                 message: "The weather service isn't responding.")
            self.getLocationWeatherButton.isEnabled = true
            self.getCityWeatherButton.isEnabled = (self.cityLabel.text?.characters.count)! > 0
        }
        print("didNotGetWeather error: \(error)")
    }
    

    // MARK: - CLLocationManagerDelegate and related methods
    
    func getLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            showSimpleAlert(
                title: "Please turn on location services",
                message: "This app needs location services in order to report the weather " +
                    "for your current location.\n" +
                "Go to Settings → Privacy → Location Services and turn location services on."
            )
            getLocationWeatherButton.isEnabled = true
            return
        }
        
        let authStatus = CLLocationManager.authorizationStatus()
        guard authStatus == .authorizedWhenInUse else {
            switch authStatus {
            case .denied, .restricted:
                let alert = UIAlertController(
                    title: "Location services for this app are disabled",
                    message: "In order to get your current location, please open Settings for this app, choose \"Location\"  and set \"Allow location access\" to \"While Using the App\".",
                    preferredStyle: .alert
                )
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let openSettingsAction = UIAlertAction(title: "Open Settings", style: .default) {
                    action in
                    guard let url = URL(string: UIApplicationOpenSettingsURLString) else{
                        return
                    }
                        
                         UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    
                }
                alert.addAction(cancelAction)
                alert.addAction(openSettingsAction)
                present(alert, animated: true, completion: nil)
                getLocationWeatherButton.isEnabled = true
                return
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            default:
                print("Oops! Shouldn't have come this far.")
            }
            
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        weather.getWeatherByCoordinates(latitude: newLocation.coordinate.latitude,
                                        longitude: newLocation.coordinate.longitude)
        
     //   weather.getDailyWeatherByCoordinates(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)


    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // This method is called asynchronously, which means it won't execute in the main queue.
        // All UI code needs to execute in the main queue, which is why we're wrapping the call
        // to showSimpleAlert(title:message:) in a dispatch_async() call.
        DispatchQueue.main.async {
            self.showSimpleAlert(title: "Can't determine your location",
                                 message: "The GPS and other location services aren't responding.")
        }
        print("locationManager didFailWithError: \(error)")
    }
    
    
    
    
    // MARK: - Set up Views
    func setupTopView(){
        
        view.addSubview(topView)
        topView.addSubview(cityLabel)
        topView.addSubview(getCityWeatherButton)
        topView.addSubview(descriptionLabel)
        topView.addSubview(maxLabel)
        topView.addSubview(minLabel)
        topView.addSubview(temperatureLabel)
        topView.addSubview(dateLabel)
        topView.addSubview(getLocationWeatherButton)

//        

        _ = topView.anchor(view.topAnchor, left: view.leftAnchor,bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: view.frame.height )
    
        
  
        
        _ = cityLabel.anchor(topView.topAnchor, left: topView.leftAnchor ,bottom: nil, right: nil, topConstant: 70, leftConstant: 20 , bottomConstant: 0, rightConstant: 0, widthConstant: 250, heightConstant: 40)
        
        _ = getCityWeatherButton.anchor(topView.topAnchor, left: cityLabel.rightAnchor ,bottom: nil, right: nil, topConstant: 100, leftConstant: 0 , bottomConstant: 0, rightConstant: 0, widthConstant: 40, heightConstant: 40)

        _ = getCityWeatherButton.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor).isActive = true
        _ = dateLabel.anchor(cityLabel.bottomAnchor, left: topView.leftAnchor ,bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: view.frame.width, heightConstant: 30)
        
        _ = temperatureLabel.anchor(dateLabel.bottomAnchor, left: topView.leftAnchor ,bottom: nil, right: getLocationWeatherButton.leftAnchor, topConstant: 5, leftConstant: 30, bottomConstant: 0, rightConstant: 10, widthConstant: 160, heightConstant: 55)
        
        _ = descriptionLabel.anchor(temperatureLabel.bottomAnchor, left: topView.leftAnchor ,bottom: nil, right: nil, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant:120, heightConstant: 30)

        _ = maxLabel.anchor(temperatureLabel.bottomAnchor, left: descriptionLabel.rightAnchor ,bottom: nil, right: nil, topConstant: 5, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant:30, heightConstant: 30)
        
        _ = maxLabel.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor).isActive = true
        
        _ = minLabel.anchor(temperatureLabel.bottomAnchor, left: maxLabel.rightAnchor ,bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant:30, heightConstant: 30)
        _ = minLabel.centerYAnchor.constraint(equalTo: maxLabel.centerYAnchor).isActive = true

        
//        _ = getLocationWeatherButton.anchor(nil, left: temperatureLabel.centerYAnchor ,bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)

        _ = getLocationWeatherButton.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor).isActive = true
        

      
     
    }
    
    
    
    // MARK: - Utility methods
    // -----------------------
    
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style:  .default,
            handler: nil
        )
        alert.addAction(okAction)
        present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    //    // MARK: - UITextFieldDelegate and related methods
    //    // -----------------------------------------------
    //
    //    // Enable the "Get weather for the city above" button
    //    // if the city text field contains any text,
    //    // disable it otherwise.
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(
            in: range,
            with: string).trimmingCharacters(in: .whitespacesAndNewlines)
        getCityWeatherButton.isEnabled = prospectiveText.characters.count > 0
        return true
    }
    
    // Pressing the clear button on the text field (the x-in-a-circle button
    // on the right side of the field)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        textField.text = ""
        
        getCityWeatherButton.isEnabled = false
        return true
    }
    
    // Pressing the return button on the keyboard should be like
    // pressing the "Get weather for the city above" button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.cityLabel.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    // Tapping on the view should dismiss the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    

    

}

