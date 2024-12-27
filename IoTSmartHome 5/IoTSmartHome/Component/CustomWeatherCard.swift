
import SwiftUI

struct CustomWeatherCard: View {
    
    let title: String
    let subtitle: String
    let color: Color
    let height: CGFloat
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
            Text(subtitle)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: height)
        .background(color.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 3)
    }
}

#Preview {
    CustomWeatherCard(title: "Smart Lamp", subtitle: "Off", color: .cyan, height: 200)
        .padding()
}
