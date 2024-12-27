//
//  ThermometerSummaryView.swift
//  IoTSmartHome
//
//  Created by ÖMER  on 24.12.2024.
//

import SwiftUI

struct ThermometerSummaryView: View {
    
    var status: ThermostatStatus
    var showStatus: Bool
    var temperature: CGFloat
    
    var body: some View {
        VStack(spacing: 0){
            Text(status.rawValue)
                .font(.headline)
                .foregroundStyle(.white)
                .opacity(showStatus ? 0.6 : 0)
                .animation(.easeOut(duration: 0.5), value: showStatus)
            
            Text("\(temperature ,specifier: "%.0f")")
                .font(.system(size: 54))
                .foregroundStyle(.white)
            
            Image(systemName: "leaf.fill")
                .font(.title2.bold())
                .foregroundStyle(.green)
        }
        .padding(.top, 40)
    }
}

#Preview {
    ThermometerSummaryView(status: .heating, showStatus: true , temperature: 12)
}
