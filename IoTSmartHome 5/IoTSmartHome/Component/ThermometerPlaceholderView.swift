//
//  ThermometerPlaceholderView.swift
//  IoTSmartHome
//
//  Created by ÖMER  on 24.12.2024.
//

import SwiftUI

struct ThermometerPlaceholderView: View {
    
    private let placeholderSize: CGFloat = 244
    
    
    var body: some View {
        Circle()
            .fill(LinearGradient(colors: [Color.black, Color.blue.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: placeholderSize, height: placeholderSize)
            .shadow(color: Color.black, radius: 30, x: 0, y: 15)
            .overlay{
                Circle()
                    .stroke(LinearGradient(colors: [Color.black, Color.white], startPoint: .top, endPoint: .bottom),lineWidth: 0.8)
            }
            .overlay{
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .blur(radius: 7)
                    .offset(x: 0, y: 3)
                    .mask{
                        Circle()
                            .fill(LinearGradient(colors: [.black, .clear], startPoint: .top, endPoint: .bottom))
                    }
            }
    }
}

#Preview {
    ThermometerPlaceholderView()
}
