//
//  ThermostatView.swift
//  IoTSmartHome
//
//  Created by ÖMER  on 24.12.2024.
//

import SwiftUI

struct ThermostatView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                
                VStack(spacing: 0){
                    ThermometerView()
                }
            }
            .navigationTitle("Thermostat")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ThermostatView()
}
