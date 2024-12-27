//
//  ThermometerDialView.swift
//  IoTSmartHome
//
//  Created by ÖMER  on 24.12.2024.
//

import SwiftUI

struct ThermometerDialView: View {
    
    private let outerDialSize: CGFloat = 200
    private let innerDialSize: CGFloat = 172
    private let setpointSize: CGFloat = 15
    
    var degrees: CGFloat = 0
    
    var body: some View {
        ZStack{
            Circle()
                .fill(LinearGradient(colors: [Color.gray], startPoint: .top, endPoint: .bottom))
                .frame(width: outerDialSize, height: outerDialSize)
                .shadow(color: .black.opacity(0.2), radius: 60, x: 0, y: 30)
                .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 8)
                .overlay{
                    Circle()
                        .stroke(.white.opacity(0.2), lineWidth: 4)
                        .blur(radius: 8)
                        .offset(x:3, y: 3)
                        .mask{
                            Circle()
                                .fill(LinearGradient(colors: [Color.black, .clear], startPoint: .top, endPoint: .bottom))
                        }
                }
            
            Circle()
                .fill(LinearGradient(colors: [Color.gray, .gray.opacity(0.7)], startPoint: .top, endPoint: .bottom))
                .frame(width: innerDialSize, height: innerDialSize)
            Circle()
                .fill(LinearGradient(colors: [Color.blue, .black.opacity(0.5)], startPoint: .top, endPoint: .bottom))
                .frame(width: setpointSize, height: setpointSize)
                .frame(width: innerDialSize, height: innerDialSize, alignment: .top)
                .offset(x: 0, y: 7.5)
                .rotationEffect(.degrees(degrees + 180))
                .animation(.easeInOut(duration: 1), value: degrees)
            
            
            
        }
    }
}

#Preview {
    ThermometerDialView()
}
