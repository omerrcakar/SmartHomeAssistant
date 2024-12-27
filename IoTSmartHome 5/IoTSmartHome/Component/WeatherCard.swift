//
//  WeatherCard.swift
//  IoTSmartHome
//
//  Created by ÖMER  on 4.12.2024.
//

import SwiftUI

struct WeatherCard: View {
    
    let cityName: String
    let temperature: String
    let weatherDescription: String
    let weatherIcon: String
    let humidity: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.7),Color.purple.opacity(0.7)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 150)
                .shadow(radius: 10)
            
            HStack{
                if let url = URL(string: weatherIcon){
                    AsyncImage(url: url){ phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        case .failure:
                            Image(systemName: "cloud.slash.fill") // Yükleme başarısızsa gösterilecek simge
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                                        
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5){
                    
                    Text(cityName)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text(temperature)
                        .font(.system(size: 30))
                        .bold()
                        .foregroundStyle(.white)
                    
                    Text(weatherDescription)
                        .font(.caption)
                        .foregroundStyle(.white)
                        .bold()
                    
                    Text("Humidity: \(humidity)")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .bold()
                }
                
                
            }
            .padding(.horizontal)
    
        }
        

    }
}

#Preview {
    WeatherCard(cityName: "İstanbul", temperature: "1 C", weatherDescription: "bla bla", weatherIcon: "plus", humidity: "12")
        .padding()
}
