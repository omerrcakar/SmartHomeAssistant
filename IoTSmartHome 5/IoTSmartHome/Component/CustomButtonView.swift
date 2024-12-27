
import SwiftUI

struct CustomButtonView: View {
    
    var title: String
    var imageName: String? // opsiyonel
    var isSystemImage: Bool = true
    var action: () -> Void // bir closure dur. Değişken gibi tanımlanır. action ismi, bu closure'ın hangi adı taşıyacağını belirtir.Bu closure'ın parametre almadığını () ve bir değer döndürmediğini (Void) ifade eder. Yani bu closure, içinde tanımlanan kodu çalıştırır ama hiçbir parametre almaz ve geri dönüş değeri döndürmez.
    var titleColor: Color
    var backgroundColor: Color
    var width: CGFloat
    var height: CGFloat
    var isOutlied: Bool = false
    var strokeColor: Color
    
    var body: some View {
        Button{
            action()
        }label: {
            HStack{
                
                if let imageName = imageName{ // imageName nil değilse resmi göster
                    if isSystemImage{
                        Image(systemName: imageName)
                            .font(.title3)
                    }else{
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
                
                Text(title)
                    .fontWeight(.bold)
                
            }
            .frame(width: width, height: height)
            .padding()
            .foregroundStyle(titleColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isOutlied ? strokeColor : Color.clear, lineWidth: isOutlied ? 2 : 0)
            )
        }
        
    }
}

#Preview {
    CustomButtonView(title: "Edit", imageName: "pencil",isSystemImage: true, action: {
        
    }, titleColor: .black, backgroundColor: .gray.opacity(0.2), width: 90, height: 20, strokeColor: .black)
}
