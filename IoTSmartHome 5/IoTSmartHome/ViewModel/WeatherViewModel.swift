//
//  WeatherViewModel.swift
//  SmartHome
//
//  Created by ÖMER  on 3.12.2024.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherViewModel : NSObject,ObservableObject {
    
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var weatherDescription: String = ""
    @Published var humidity: String = ""
    @Published var isLoading: Bool = false
    @Published var searchQuery: String = ""
    @Published var weatherIcon: String = "" // İkon URL'si
    
    private let apiKey = "a77df4609f5c00b5c527231ad1fd8f48"
    
    func fetchWeather(for city: String){
        
        isLoading = true
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(apiKey)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: WeatherResponse.self){ responds in
                self.isLoading = false
                switch responds.result {
                case.success(let weatherData):
                    self.cityName = weatherData.name
                    self.temperature = "\(weatherData.main.temp)°C"
                    self.humidity = "\(weatherData.main.humidity)%"
                    self.weatherDescription = weatherData.weather.first?.description ?? "N/A"
                    self.weatherIcon = "https://openweathermap.org/img/wn/\(weatherData.weather.first?.icon ?? "01d")@2x.png"
                case.failure(let error):
                    print("Hata \(error.localizedDescription)")
                    self.cityName = "Şehir bulunamadı"
                    self.temperature = ""
                    self.weatherDescription = ""
                    self.humidity = ""
                    self.weatherIcon = ""
                }
            }
    }
}
