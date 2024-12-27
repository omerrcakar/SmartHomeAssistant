
import SwiftUI

struct CustomDeviceCard: View {
    
    let title: String
    let subtitle: String
    let color: Color
    let height: CGFloat
    let image: String
    
    
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 20){
                Image("\(image)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .shadow(radius: 6)
                VStack(alignment: .leading){
                    Text(title)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    Text(subtitle)
                        .foregroundStyle(.secondary)
                }
            }
            
            
            Toggle("", isOn: $isOn)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: height)
        .background(color.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 3)
    }
}

#Preview {
    CustomDeviceCard(title: "Smart Lamp", subtitle: "Off", color: .gray, height: 200,image: "lampOn", isOn: .constant(false))
        .padding()
}
