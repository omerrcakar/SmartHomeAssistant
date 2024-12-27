//
//  WeatherView.swift
//  SmartHome
//
//  Created by ÖMER  on 3.12.2024.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    @State private var locationManager = CLLocationManager()
    
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                CustomTextFieldView("City", text: $viewModel.searchQuery)
                Spacer()
                Button{
                    viewModel.fetchWeather(for: viewModel.searchQuery)
                }label: {
                    Text("Search")
                        .font(.caption)
                        .foregroundStyle(Color("color3"))
                        
                }
                Spacer()
            }
            .padding(.vertical, 5)
            
            if viewModel.isLoading{
                ProgressView("Yükleniyor...")
            }else if !viewModel.cityName.isEmpty{
                WeatherCard(
                    cityName: viewModel.cityName,
                    temperature: viewModel.temperature,
                    weatherDescription: viewModel.weatherDescription,
                    weatherIcon: viewModel.weatherIcon,
                    humidity: viewModel.humidity
                )
                
            }
        }
        
        
    }
    
   
    
    
    
}

#Preview {
    WeatherView()
}
